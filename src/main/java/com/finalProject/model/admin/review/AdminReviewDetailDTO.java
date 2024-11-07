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
public class AdminReviewDetailDTO {
	private int review_no;
	private int product_no;
	private String member_id;
	private String review_title;
	private String review_content;
	private Timestamp register_date;
}
