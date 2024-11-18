package com.finalProject.model.admin.black;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BlackMemberDTO {
	private List<String> gender_list;
	private List<Integer> level_list;
	private String member_id;
	private String black;
	private String member_name;
	private String reg_date_start;
	private String reg_date_end;
	private int pageNo;
	private int pagingSize;
}
