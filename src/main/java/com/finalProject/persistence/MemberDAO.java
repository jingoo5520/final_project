package com.finalProject.persistence;

import com.finalProject.model.MemberDTO;

public interface MemberDAO {

	// ���̵� �ߺ��˻�
	int selectDuplicateId(String tmpUserId) throws Exception;

	// ȸ������
	int insertMember(MemberDTO registerMember) throws Exception;



}
