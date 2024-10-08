package com.finalProject.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;
import com.finalProject.persistence.MemberDAO;


@Service
public class MemberServiceImpl implements MemberService{

	@Inject
	private MemberDAO memberDAO;
	
	// 로그인 테스트용
	@Override
	public MemberDTO login(LoginDTO loginDTO) throws Exception {
		MemberDTO data = memberDAO.login(loginDTO);
		return data;
	}

}
