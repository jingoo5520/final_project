package com.finalProject.service;

import com.finalProject.model.MemberDTO;

public interface MemberService {

	// ���̵� �ߺ��˻�
	boolean idIsDuplicate(String tmpUserId) throws Exception;

	// ȸ������
	boolean saveMember(MemberDTO registerMember) throws Exception;

	
	
	
}
