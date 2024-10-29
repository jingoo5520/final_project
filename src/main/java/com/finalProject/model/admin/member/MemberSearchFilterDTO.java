package com.finalProject.model.admin.member;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class MemberSearchFilterDTO {
	private String[] genders;
	private String[] levels;
	private String member_id;
	private String member_name;
	private int birthday_start;
	private int birthday_end;
	private Timestamp reg_date_start;
	private Timestamp reg_date_end;
	private int pageNo;
	private int pagingSize;
	private int pageCntPerBlock;
}
