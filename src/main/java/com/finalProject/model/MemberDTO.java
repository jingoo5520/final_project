package com.finalProject.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Getter
@Setter
public class MemberDTO {
	private String member_id;
	private String member_pwd;
	private String member_name;
	private String nickname;
	private String birthday;
	private String gender;
	private String address; // 기본주소
	private String zipCode; // 우편번호
	private String address2; //상세주소
	private String email;
	private String phone_number;
	private String naver_id; // 네이버 회원 구분용
}
