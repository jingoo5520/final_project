package com.finalProject.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	SqlSession ses;
	
	private String ns = "com.finalProject.mappers.memberMapper.";

	// 로그인 테스트
	@Override
	public MemberDTO login(LoginDTO loginDTO) throws Exception {
		return ses.selectOne(ns + "login", loginDTO);
	}

}
