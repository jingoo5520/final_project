package com.finalProject.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Component // Spring 컨테이너가 해당 클래스를 빈으로 등록
public class KakaoUtil {

	private String key;
	private String redirectUri;
	private String getCodeUrl;
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
	public Map<String, Object> getUserInfo(String accessToken) {
		// 사용자 정보를 저장할 HashMap 생성
		HashMap<String, Object> userInfo = new HashMap<>();
		// 카카오 API의 사용자 정보 요청 URL
		String reqUrl = "https://kapi.kakao.com/v2/user/me";

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

			// JSON 파서를 사용하여 응답 문자열을 JSON 객체로 변환
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			// JSON 객체에서 필요한 정보 추출
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			// 사용자 닉네임과 이메일을 추출
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakaoAccount.getAsJsonObject().get("email").getAsString();

			// 추출한 정보를 userInfo 맵에 저장
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);

			// BufferedReader 닫기
			br.close();

		} catch (Exception e) {
			// 예외 발생 시 스택 트레이스 출력
			e.printStackTrace();
		}

		// 사용자 정보를 담고 있는 맵 반환
		return userInfo;
	}

	// kakao.properties파일 읽기
	private void readProperties() throws FileNotFoundException, IOException {
		Properties prop = new Properties();
		// 해당 경로의 properties를 받음.
		prop.load(new FileReader("D:\\my\\coding\\Flnal_2team\\final_project\\src\\main\\resources\\kakao.properties"));
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
