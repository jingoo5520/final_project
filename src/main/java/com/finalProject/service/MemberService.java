package com.finalProject.service;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;

public interface MemberService {

	// 로그인 테스트용
	MemberDTO login(LoginDTO loginDTO) throws Exception;
	
}
