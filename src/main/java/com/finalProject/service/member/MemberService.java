package com.finalProject.service.member;

import java.util.Map;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.SignUpDTO;

public interface MemberService {

	// 로그인
	LoginDTO login(LoginDTO loginDTO) throws Exception;

	// id, email, phone_number 중복 체크
	boolean autoDuplicate(Map<String, Object> map) throws Exception;

	// 회원가입
	int signUp(SignUpDTO signUpDTO) throws Exception;

	// 자동 로그인 정보 저장
	void setAutoLogin(String member_id, String code, int AUTOLOGIN_DATE) throws Exception;

	// 자동 로그인 정보 조회
	LoginDTO getAutoLogin(String autologin_code) throws Exception;
	
}
