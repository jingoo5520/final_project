package com.finalProject.persistence;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;

public interface MemberDAO {

	// 로그인 테스트
	MemberDTO login(LoginDTO loginDTO) throws Exception;
	
}
