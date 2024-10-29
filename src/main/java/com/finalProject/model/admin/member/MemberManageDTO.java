package com.finalProject.model.admin.member;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class MemberManageDTO {
	private String member_id;
	private String member_name;
	private String phone_number;
	private int birthday;
	private String gender;
	private String member_level;
	private Timestamp reg_date;
}
