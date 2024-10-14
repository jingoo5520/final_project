package com.finalProject.persistence;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.LoginMemberDTO;

public interface MemberDAO {

	// 로그인
	LoginDTO login(LoginDTO loginDTO) throws Exception;

	// id 중복 체크
	boolean idDuplicate(String value) throws Exception;

	// email 중복 체크
	boolean emailDuplicate(String value) throws Exception;

	// phone_number 중복 체크
	boolean phoneDuplicate(String value) throws Exception;
	
}
