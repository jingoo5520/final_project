package com.finalProject.model.admin.black;

import java.util.Date;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@Service
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BlackMemberVO {
	private String member_id;
	private String member_name;
	private String phone_number;
	private String member_status;
	private int birthday;
	private String gender;
	private int member_level;
	private Date reg_date;

}
