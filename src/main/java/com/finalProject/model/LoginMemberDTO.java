package com.finalProject.model;

import java.sql.Timestamp;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Setter
@AllArgsConstructor
@ToString
// 
public class LoginMemberDTO {
	private String member_id; // 회원 아이디
	private String member_name; // 회원 이름
	private String member_pwd; // 회원 비밀번호
//	private String phone_number; // 폰번호
//	private int birthday; // 생년월일
//	private String gender; // 성별 M, F, N
//	private String email; // 이메일
//	private String address; // 주소
//	private int member_point; // 포인트
//	private int member_level; // 등급
//	private Timestamp reg_date; // 가입일
//	private String member_status; // 상태
//	private String nickName; // 별명
//	private String member_image; // 이미지
//	private String is_admin; // 권한 0 ,1 ,9
}