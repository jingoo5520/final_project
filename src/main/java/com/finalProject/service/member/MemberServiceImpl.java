package com.finalProject.service.member;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;
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
	public int signUp(MemberDTO signUpDTO) throws Exception {
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

	// 마이 페이지 비밀번호 인증
	@Override
	public boolean auth(String member_id, String member_pwd) throws Exception {
		return memberDAO.auth(member_id, member_pwd);
	}

	// 마이 페이지 회원 정보 조회
	@Override
	public MemberDTO getMember(String member_id) throws Exception {
		return memberDAO.getMember(member_id);
	}

	// 마이 페이지 회원 정보 수정
	@Override
	public boolean updateMember(MemberDTO memberDTO) throws Exception {
		return memberDAO.updateMember(memberDTO);
	}

	// 마이 페이지 비밀번호 변경
	@Override
	public boolean updateMemberPwd(Map<String, String> map) throws Exception {
		return memberDAO.updateMemberPwd(map);
	}

	// 마이 페이지 회원탈퇴
	@Override
	public boolean withDrawMember(String member_id) throws Exception {
		return memberDAO.withDrawMember(member_id);
	}

	// 아이디 찾기
	@Override
	public LoginDTO findIdbyEmail(String email) throws Exception {
		return memberDAO.findIdbyEmail(email);
	}

	// 비밀번호 찾기
	@Transactional
	@Override
	public boolean findPwd(String email, String member_id, String member_pwd) throws Exception {
		boolean result = false;
		if(memberDAO.findPwd(email, member_id)) {
			if(memberDAO.updateRandomPwd(member_pwd, member_id)) {
				result = true;
			}
		}
		return result;
	}

	// 회원의 찜목록 조회
	@Override
	public int[] getWishList(String member_id) throws Exception {
		return memberDAO.getWishList(member_id);
	}
	
	

}