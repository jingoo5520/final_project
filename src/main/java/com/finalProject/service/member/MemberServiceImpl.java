package com.finalProject.service.member;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.SignUpDTO;
import com.finalProject.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO memberDAO;

	// 로그인
	@Override
	public LoginDTO login(LoginDTO loginDTO) throws Exception {
		LoginDTO data = memberDAO.login(loginDTO);
		return data;
	}

	// id, email, phone_number 중복 체크
	@Override
	public boolean autoDuplicate(Map<String, Object> map) throws Exception {
		return memberDAO.autoDuplicate(map);
	}

	// 회원가입
	@Override
	public int signUp(SignUpDTO signUpDTO) throws Exception {
		return memberDAO.signUp(signUpDTO);
	}

	// 자동 로그인 정보 저장
	@Override
	public void setAutoLogin(String member_id, String code, int AUTOLOGIN_DATE) throws Exception {
		memberDAO.setAutoLogin(member_id, code, AUTOLOGIN_DATE);
	}

	// 자동 로그인 정보 조회
	@Override
	public LoginDTO getAutoLogin(String autologin_code) throws Exception {
		return memberDAO.getAutoLogin(autologin_code);
	}

}
