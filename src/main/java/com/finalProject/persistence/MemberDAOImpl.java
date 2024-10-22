package com.finalProject.persistence;

import java.util.HashMap;
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

	// 회원가입
	@Override
	public int signUp(SignUpDTO signUpDTO) throws Exception {
		return ses.insert(ns + "signUpMember", signUpDTO);
	}

	// 자동 로그인 정보 저장
	@Override
	public void setAutoLogin(String member_id, String code, int AUTOLOGIN_DATE) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("autologin_code", code); // 자동로그인 코드
		map.put("autologin_date", AUTOLOGIN_DATE); // 자동로그인 유효기간
		ses.update(ns + "updateAutoLoginData", map);
	}

	// 자동 로그인 정보 조회
	@Override
	public LoginDTO getAutoLogin(String autologin_code) throws Exception {
		return ses.selectOne(ns + "selectAutoLoginData", autologin_code);
	}

	// 마이 페이지 비밀번호 인증
	@Override
	public boolean auth(String member_id, String member_pwd) throws Exception {
		boolean result = false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("member_pwd", member_pwd);
		LoginDTO loginDTO = ses.selectOne(ns+"login", map);
		if(loginDTO != null) {
			result = true;
		}
		
		return result;
	}

}
