package com.finalProject.model.admin.inquiry;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class InquirySearchFilterDTO {
	private String[] statuses;
	private String[] types;
	private String member_id;
	private String member_name;
	private Timestamp regDate_start;
	private Timestamp regDate_end;
	private int pageNo;
	private int pagingSize;
	private int pageCntPerBlock;
}
