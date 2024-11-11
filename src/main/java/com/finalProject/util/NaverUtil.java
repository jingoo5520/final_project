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
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

import com.finalProject.model.MemberDTO;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Component // Spring 컨테이너가 해당 클래스를 빈으로 등록
public class NaverUtil {

	private String ClientID;
	private String Client_Secret;
	private String Callback_URL;
	private String getCodeUrl;
	private String redirectUri;

	// 코드 받기
	public void getCode(HttpServletResponse response) throws FileNotFoundException, IOException {
		readProperties();
		String url = getCodeUrl + "?client_id=" + ClientID + "&redirect_uri=" + redirectUri + "&response_type=code" + "&scope=email";
		System.out.println(url);
		response.sendRedirect(url);
	}

	// 토큰 받기
	public String getAccessToken(String code) {
		String accessToken = "";
		String reqUrl = "https://nid.naver.com/oauth2.0/token"; // 네이버 API의 토큰 발급 URL

		try {
			// HTTP 연결 설정
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// 필수 헤더 세팅
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true); // POST 데이터 전송을 위한 설정

			// POST 파라미터 설정
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=").append(ClientID);
			sb.append("&client_secret=").append(Client_Secret);
			sb.append("&redirect_uri=").append(redirectUri);
			sb.append("&code=").append(code);

			bw.write(sb.toString());
			bw.flush();

			// 응답 코드 확인
			int responseCode = conn.getResponseCode();
			BufferedReader br;
			if (responseCode >= 200 && responseCode < 300) {
				// 정상 응답
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				// 오류 응답
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
				String errorResponse = readResponse(br);
				System.out.println("오류 응답: " + errorResponse); // 오류 응답 내용 출력
				return null; // 오류 발생 시 null 반환
			}

			// 응답 내용 읽기
			String result = readResponse(br);
			System.out.println("응답: " + result); // 응답 내용 출력

			// JSON 파싱하여 access_token 추출
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			JsonObject jsonObject = element.getAsJsonObject();

			if (jsonObject.has("access_token")) {
				accessToken = jsonObject.get("access_token").getAsString();
			} else {
				System.out.println("access_token을 찾을 수 없습니다.");
			}

			br.close();
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return accessToken; // 토큰 반환
	}

	// 유저 정보 받기
	public MemberDTO getUserInfo(String accessToken) {
		MemberDTO userInfo = new MemberDTO();
		// 네이버 API의 사용자 정보 요청 URL
		String reqUrl = "https://openapi.naver.com/v1/nid/me";

		try {
			// 요청할 URL 객체 생성
			URL url = new URL(reqUrl);
			// URLConnection을 HttpURLConnection으로 변환
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// HTTP 메서드를 GET으로 설정 (네이버 API는 GET 방식)
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
			JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();

			// 사용자 정보를 추출
			String nickname = response.getAsJsonObject().get("nickname").getAsString(); // 닉네임
			String id = response.getAsJsonObject().get("id").getAsString(); // 아이디
			String gender = response.getAsJsonObject().get("gender").getAsString(); // 성별
			String birthday = response.getAsJsonObject().get("birthday").getAsString(); // 생일 (MM-DD)
			String birthyear = response.getAsJsonObject().get("birthyear").getAsString(); // 생일 (YYYY)
			String birth = birthyear + birthday.substring(0, 2) + birthday.substring(3, 5); // YYYYMMDD

			// 추출한 정보를 userInfo(MemberDTO)에 저장
			userInfo.setNaver_id(id);
			userInfo.setNickname(nickname);
			userInfo.setBirthday(birth);
			userInfo.setGender(gender);
			
			// BufferedReader 닫기
			br.close();

		} catch (Exception e) {
			// 예외 발생 시 스택 트레이스 출력
			e.printStackTrace();
		}

		// 사용자 정보를 담고 있는 DTO 반환
		return userInfo;
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

	// naver.properties파일 읽기
	private void readProperties() throws FileNotFoundException, IOException {
		Properties prop = new Properties();
		// 해당 경로의 properties를 받음.
		// 클래스패스에서 properties 파일을 읽음 src/main/resources
		InputStream input = getClass().getClassLoader().getResourceAsStream("naver.properties");
		if (input == null) {
			System.out.println("kakao.properties를 찾을수 없습니다.");
		}
		prop.load(input);
		// 필요한 값 저장
		this.ClientID = prop.get("ClientID") + "";
		this.Client_Secret = prop.get("Client_Secret") + "";
		this.Callback_URL = prop.get("Callback_URL") + "";
		this.getCodeUrl = prop.get("getCodeUrl") + "";
		this.redirectUri = prop.get("redirectUri") + "";
	}
}
