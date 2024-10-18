package com.finalProject.persistence;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.SignUpDTO;

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

	// id, email, phone_number 중복 체크
	@Override
	public boolean autoDuplicate(Map<String, Object> map) {
		boolean result = false;
		// 중복인 경우 true
		if ((int) ses.selectOne(ns + "autoDuplicate", map) >= 1) {
			result = true;
			System.out.println("중복");
		}
		return result;
	}

	@Override
	public int signUp(SignUpDTO signUpDTO) throws Exception {
		return ses.insert(ns + "signUpMember", signUpDTO);
	}

}
