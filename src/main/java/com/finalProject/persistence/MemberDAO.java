package com.finalProject.persistence;

import java.util.Map;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.SignUpDTO;

public interface MemberDAO {

	// 로그인
	LoginDTO login(LoginDTO loginDTO) throws Exception;

	// id, email, phone_number 중복 체크
	boolean autoDuplicate(Map<String, Object> map) throws Exception;

	// 회원가입
	int signUp(SignUpDTO signUpDTO) throws Exception;

}
