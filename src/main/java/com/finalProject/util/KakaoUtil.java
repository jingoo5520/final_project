package com.finalProject.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.finalProject.model.MemberDTO;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Component // Spring 컨테이너가 해당 클래스를 빈으로 등록
public class KakaoUtil {

	private String key; // kakao REST API 키
	private String redirectUri; // 코드발급 api에 쿼리파라미터로 포함될 uri
	private String getCodeUrl; // kakao 로그인 api
	private String response_type;
	private String state;
	private String getTokenUrl;
	private String client_secret;
	private String getUserInfo;

	// 코드 받기
	public void getCode(HttpServletResponse response) throws FileNotFoundException, IOException {
		readProperties();
		String url = getCodeUrl + "?state=" + state + "&redirect_uri=" + redirectUri + "&client_id=" + key
				+ "&response_type=" + response_type;
		System.out.println(url);
		response.sendRedirect(url);
	}

	// 토큰 받기
	public String getAccessToken(String code) {
		String accessToken = "";
		String refreshToken = "";
		String reqUrl = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// 필수 헤더 세팅
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true); // OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();

			// 필수 쿼리 파라미터 세팅
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=").append(key);
			sb.append("&redirect_uri=").append(redirectUri);
			sb.append("&code=").append(code);

			bw.write(sb.toString());
			bw.flush();

			int responseCode = conn.getResponseCode();

			BufferedReader br;
			if (responseCode >= 200 && responseCode < 300) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			String line = "";
			StringBuilder responseSb = new StringBuilder();
			while ((line = br.readLine()) != null) {
				responseSb.append(line);
			}
			String result = responseSb.toString();

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			accessToken = element.getAsJsonObject().get("access_token").getAsString();
			refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

			br.close();
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return accessToken;

	}

	// 유저 정보 받기
	public MemberDTO getUserInfo(String accessToken) {
		MemberDTO userInfo = new MemberDTO();
		// 카카오 API의 사용자 정보 요청 URL
		String reqUrl = "https://kapi.kakao.com/v2/user/me";
		userInfo = getAddress(accessToken, userInfo);

		try {
			// 요청할 URL 객체 생성
			URL url = new URL(reqUrl);
			// URLConnection을 HttpURLConnection으로 변환
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// HTTP 메서드를 POST로 설정
			conn.setRequestMethod("POST");
			// Authorization 헤더에 Bearer 토큰 추가
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			// Content-type 설정
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

			// 서버의 응답 코드 가져오기
			int responseCode = conn.getResponseCode();

			BufferedReader br;
			// 응답 코드가 200~300 범위이면 성공적인 요청
			if (responseCode >= 200 && responseCode <= 300) {
				// 입력 스트림을 통해 서버의 응답을 읽기 위해 BufferedReader 생성
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				// 오류가 발생한 경우 오류 스트림을 읽기 위해 BufferedReader 생성
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			// 응답 데이터를 저장할 StringBuilder
			String line = "";
			StringBuilder responseSb = new StringBuilder();
			// BufferedReader를 통해 한 줄씩 읽어서 StringBuilder에 추가
			while ((line = br.readLine()) != null) {
				responseSb.append(line);
			}

			// 최종적으로 읽은 응답을 문자열로 변환
			String result = responseSb.toString();
			System.out.println(result);

			// JSON 파서를 사용하여 응답 문자열을 JSON 객체로 변환
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			// JSON 객체에서 필요한 정보 추출
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			// 사용자 정보를 추출
			String nickname = properties.getAsJsonObject().get("nickname").getAsString(); // 닉네임
			String email = kakaoAccount.getAsJsonObject().get("email").getAsString(); // 이메일
			String gender = kakaoAccount.getAsJsonObject().get("gender").getAsString(); // 성별
			String birthyear = kakaoAccount.getAsJsonObject().get("birthyear").getAsString(); // 출생 연도(YYYY)
			String birthday = kakaoAccount.getAsJsonObject().get("birthday").getAsString(); // 생일 (MM-DD)
			String birth = birthyear + birthday;

			// 추출한 정보를 userInfo(MemberDTO)에 저장
			userInfo.setNickname(nickname);
			userInfo.setBirthday(birth);
			userInfo.setEmail(email);
			if (gender.equals("male")) {
				userInfo.setGender("M");
			} else if (gender.equals("female")) {
				userInfo.setGender("F");
			} else {
				userInfo.setGender("N");
			}

			// BufferedReader 닫기
			br.close();

		} catch (Exception e) {
			// 예외 발생 시 스택 트레이스 출력
			e.printStackTrace();
		}

		// 사용자 정보를 담고 있는 맵 반환
		return userInfo;
	}

	// 유저 배송지 받기
	public MemberDTO getAddress(String accessToken, MemberDTO userInfo) {
		// 카카오 API의 사용자 정보 요청 URL
		String reqUrl = "https://kapi.kakao.com/v1/user/shipping_address";

		try {
			// 요청할 URL 객체 생성
			URL url = new URL(reqUrl);
			// URLConnection을 HttpURLConnection으로 변환
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// HTTP 메서드를 POST로 설정
			conn.setRequestMethod("GET");
			// Authorization 헤더에 Bearer 토큰 추가
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);

			// 서버의 응답 코드 가져오기
			int responseCode = conn.getResponseCode();

			BufferedReader br;
			// 응답 코드가 200~300 범위이면 성공적인 요청
			if (responseCode >= 200 && responseCode <= 300) {
				// 입력 스트림을 통해 서버의 응답을 읽기 위해 BufferedReader 생성
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				// 오류가 발생한 경우 오류 스트림을 읽기 위해 BufferedReader 생성
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			// 응답 데이터를 저장할 StringBuilder
			String line = "";
			StringBuilder responseSb = new StringBuilder();
			// BufferedReader를 통해 한 줄씩 읽어서 StringBuilder에 추가
			while ((line = br.readLine()) != null) {
				responseSb.append(line);
			}

			// 최종적으로 읽은 응답을 문자열로 변환
			String result = responseSb.toString();
			System.out.println(result);

			// JSON 파서를 사용하여 응답 문자열을 JSON 객체로 변환
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			// JSON 객체에서 필요한 정보 추출
			JsonArray shippingAddressesElement = element.getAsJsonObject().get("shipping_addresses").getAsJsonArray();
			JsonObject firstAddress = shippingAddressesElement.getAsJsonArray().get(0).getAsJsonObject();

			// 사용자 정보를 추출
			String address = firstAddress.get("base_address").getAsString(); // 기본 주소
			String addressDetail = firstAddress.get("detail_address").getAsString(); // 상세 주소
			String zipCode = firstAddress.get("zone_number").getAsString(); // 우편번호

			// 추출한 정보를 userInfo(MemberDTO)에 저장
			userInfo.setAddress(address);
			userInfo.setAddress2(addressDetail);
			userInfo.setZipCode(zipCode);

			// BufferedReader 닫기
			br.close();

		} catch (Exception e) {
			// 예외 발생 시 스택 트레이스 출력
			e.printStackTrace();
		}

		// 사용자 정보를 담고 있는 맵 반환
		return userInfo;
	}

	// 로그아웃
	public void kakaoLogout(String accessToken, HttpServletRequest request) {
		// 로그아웃 API URL
		HttpSession ses = request.getSession();
		String url = "https://kapi.kakao.com/v1/user/logout";

		// 헤더에 Authorization으로 액세스 토큰 추가
		HttpHeaders headers = new HttpHeaders(); // 스프링 프레임워크 헤더스 객체 생성
		headers.set("Authorization", "Bearer " + accessToken); // api에서 요구하는 헤더 설정

		// 요청 엔티티
		HttpEntity<String> entity = new HttpEntity<>(headers); // 스프링 프레임워크 HttpEntity객체 생성 (HTTP본문과 헤더 객체)

		// RestTemplate을 사용하여 로그아웃 API 호출
		RestTemplate restTemplate = new RestTemplate(); // HTTP 요청을 보내기위해 사용하는 객체
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class); // 카카오 로그아웃api에 요청을 보내고 결과 저장

		if (response.getStatusCodeValue() == 200) {
			// 로그아웃 성공
			System.out.println("카카오 로그아웃 성공");
			ses.removeAttribute("accessToken"); // 토큰 삭제
		} else {
			// 로그아웃 실패
			System.out.println("카카오 로그아웃 실패");
		}
	}
	
	// 응답을 읽어 문자열로 반환하는 메서드
		private String readResponse(BufferedReader br) throws IOException {
			String line;
			StringBuilder responseSb = new StringBuilder();
			while ((line = br.readLine()) != null) {
				responseSb.append(line);
			}
			return responseSb.toString();
		}

	// kakao.properties파일 읽기
	private void readProperties() throws FileNotFoundException, IOException {
		Properties prop = new Properties();
		// 해당 경로의 properties를 받음.
		// 클래스패스에서 properties 파일을 읽음 src/main/resources
	    InputStream input = getClass().getClassLoader().getResourceAsStream("kakao.properties");
	    if (input == null) {
	        System.out.println("kakao.properties를 찾을수 없습니다.");
	    }
	    prop.load(input);
		// 필요한 값 저장
		this.key = prop.get("key") + "";
		this.redirectUri = prop.get("redirectUri") + "";
		this.response_type = prop.get("response_type") + "";
		this.state = prop.get("state") + "";
		this.getCodeUrl = prop.get("getCodeUrl") + "";
		this.getTokenUrl = prop.get("getTokenUrl") + "";
		this.client_secret = prop.get("client_secret") + "";
		this.getUserInfo = prop.get("getUserInfo") + "";
	}

}
