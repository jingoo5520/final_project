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
	private String address;
	private String address2;
	private String email;
	private String phone_number;
}
