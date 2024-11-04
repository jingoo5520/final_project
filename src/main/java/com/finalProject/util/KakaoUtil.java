package com.finalProject.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

@Component // Spring 컨테이너가 해당 클래스를 빈으로 등록
public class KakaoUtil {

	private String key;
	private String redirectUri;
	private String response_type;

	public void login(HttpServletResponse response) throws FileNotFoundException, IOException {
		readProperties();
		String uri = "https://kauth.kakao.com/oauth/authorize" + "?redirect_uri=" + redirectUri + "&client_id=" + key
				+ "&response_type=" + response_type;
		System.out.println(uri);
		response.sendRedirect(uri);
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
	}

	// 토큰 받기
	public String getAccessToken(String accessCode) {
		
		return null;
	}
}
