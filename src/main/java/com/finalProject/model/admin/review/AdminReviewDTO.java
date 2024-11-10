package com.finalProject.model.admin.review;

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
public class AdminReviewDTO {
	private int review_no;
	private int product_no;
	private String member_id;
	private String member_name;
	private String review_show;
	private String review_title;
	private Timestamp register_date;
	private boolean has_reply;
}
