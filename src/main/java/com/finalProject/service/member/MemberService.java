package com.finalProject.service.member;

import java.util.Map;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;

public interface MemberService {

	// 로그인
	LoginDTO login(LoginDTO loginDTO) throws Exception;

	// id, email, phone_number 중복 체크
	boolean autoDuplicate(Map<String, Object> map) throws Exception;

	// 회원가입
	int signUp(MemberDTO signUpDTO) throws Exception;

	// 자동 로그인 정보 저장
	void setAutoLogin(String member_id, String code, int AUTOLOGIN_DATE) throws Exception;

	// 자동 로그인 정보 조회
	LoginDTO getAutoLogin(String autologin_code) throws Exception;

	// 마이 페이지 비밀번호 인증
	boolean auth(String member_id, String member_pwd) throws Exception;

	// 마이 페이지 회원 정보 조회
	MemberDTO getMember(String member_id)throws Exception;

	// 마이 페이지 회원 정보 수정
	boolean updateMember(MemberDTO memberDTO)throws Exception;

	// 마이 페이지 비밀번호 변경
	boolean updateMemberPwd(Map<String, String> map)throws Exception;

	// 마이 페이지 회원탈퇴
	boolean withDrawMember(String member_id)throws Exception;

	// 아이디 찾기
	LoginDTO findIdbyEmail(String email)throws Exception;

	// 비밀번호 찾기
	boolean findPwd(String email, String member_id, String member_pwd)throws Exception;
	
	// 회원의 찜목록 조회
	int[] getWishList(String member_id)throws Exception;
	
	
	
}