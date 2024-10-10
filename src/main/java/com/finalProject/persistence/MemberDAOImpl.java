package com.finalProject.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession ses;
	
	private String ns = "com.finalProject.mappers.memberMapper.";

	// 아이디 중복검사
	@Override
	public int selectDuplicateId(String tmpUserId) throws Exception {
		return ses.selectOne(ns + "selectDuplicateId", tmpUserId);
	}
	
	// 회원삽입
	@Override
	public int insertMember(MemberDTO registerMember) throws Exception {
		return ses.insert(ns + "insertMember", registerMember);
	}

}
