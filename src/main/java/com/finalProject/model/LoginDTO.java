package com.finalProject.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
// 로그인 페이지에서 입력받을 아이디 비밀번호
public class LoginDTO {
	private String member_id;
	private String member_pwd;
	private String member_name; // 회원 이름
	private String is_admin; // 회원구분(0: 일반회원, 1: 관리자:, 9: 총관리자)
	private int member_level; // 회원 등급
	private String member_status; // 회원 상태
	private String nickname; // 별명
	
}
