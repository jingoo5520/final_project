package com.finalProject.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.LoginMemberDTO;
import com.finalProject.persistence.MemberDAO;


@Service
public class MemberServiceImpl implements MemberService{

	@Inject
	private MemberDAO memberDAO;
	
	// 로그인
	@Override
	public LoginDTO login(LoginDTO loginDTO) throws Exception {
		LoginDTO data = memberDAO.login(loginDTO);
		return data;
	}

	// id 중복 체크
	@Override
	public boolean idDuplicate(String value) throws Exception {
		return memberDAO.idDuplicate(value);
	}

	// email 중복 체크
	@Override
	public boolean emailDuplicate(String value) throws Exception {
		return memberDAO.emailDuplicate(value);
	}

	// phone_number 중복 체크
	@Override
	public boolean phoneDuplicate(String value) throws Exception {
		return memberDAO.phoneDuplicate(value);
	}

}
