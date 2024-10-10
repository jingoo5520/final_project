package com.finalProject.service;

import com.finalProject.model.MemberDTO;

public interface MemberService {

	// 아이디 중복검사
	boolean idIsDuplicate(String tmpUserId) throws Exception;

	// 회원삽입
	boolean saveMember(MemberDTO registerMember) throws Exception;

	
	
	
}
