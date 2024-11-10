package com.finalProject.model.admin.review;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class ReviewSearchFilterDTO {
	private String member_id;
	private String member_name;
	private int product_no;
	private Timestamp regDate_start;
	private Timestamp regDate_end;
	private int pageNo;
	private int pagingSize;
	private int pageCntPerBlock;
}
