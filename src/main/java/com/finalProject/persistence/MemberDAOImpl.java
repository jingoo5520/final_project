package com.finalProject.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.LoginMemberDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MemberDAOImpl implements MemberDAO {

	@Inject
	SqlSession ses;
	
	private String ns = "com.finalProject.mappers.memberMapper.";

	// 로그인
	@Override
	public LoginDTO login(LoginDTO loginDTO) throws Exception {
		return ses.selectOne(ns + "login", loginDTO);
	}

	// id 중복 체크
	@Override
	public boolean idDuplicate(String value) throws Exception {
		boolean result = false;
		// 중복인 경우 true
		if((int)ses.selectOne(ns + "idDuplicate", value)>=1) {
			result = true;
			System.out.println("중복");
		}
		return result;
	}

	// email 중복 체크
	@Override
	public boolean emailDuplicate(String value) throws Exception {
		boolean result = false;
		// 중복인 경우 true
		if((int)ses.selectOne(ns + "emailDuplicate", value)>=1) {
			result = true;
			System.out.println("중복");
		}
		return result;
	}

	// phone_number 중복 체크
	@Override
	public boolean phoneDuplicate(String value) throws Exception {
		boolean result = false;
		// 중복인 경우 true
		if((int)ses.selectOne(ns + "phoneDuplicate", value)>=1) {
			result = true;
			System.out.println("중복");
		}
		return result;
	}

}
