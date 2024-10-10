package com.finalProject.persistence;

import com.finalProject.model.MemberDTO;

public interface MemberDAO {

	// 아이디 중복검사
	int selectDuplicateId(String tmpUserId) throws Exception;

	// 회원삽입
	int insertMember(MemberDTO registerMember) throws Exception;



}
