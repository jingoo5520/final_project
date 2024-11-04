package com.finalProject.service.member;

import java.util.Map;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;

public interface MemberService {

	// 濡쒓렇�씤
	LoginDTO login(LoginDTO loginDTO) throws Exception;

	// id, email, phone_number 以묐났 泥댄겕
	boolean autoDuplicate(Map<String, Object> map) throws Exception;

	// �쉶�썝媛��엯
	int signUp(MemberDTO signUpDTO) throws Exception;

	// �옄�룞 濡쒓렇�씤 �젙蹂� ���옣
	void setAutoLogin(String member_id, String code, int AUTOLOGIN_DATE) throws Exception;

	// �옄�룞 濡쒓렇�씤 �젙蹂� 議고쉶
	LoginDTO getAutoLogin(String autologin_code) throws Exception;

	// 留덉씠 �럹�씠吏� 鍮꾨�踰덊샇 �씤利�
	boolean auth(String member_id, String member_pwd) throws Exception;

	// 留덉씠 �럹�씠吏� �쉶�썝 �젙蹂� 議고쉶
	MemberDTO getMember(String member_id)throws Exception;

	// 留덉씠 �럹�씠吏� �쉶�썝 �젙蹂� �닔�젙
	boolean updateMember(MemberDTO memberDTO)throws Exception;

	
	
	
}
