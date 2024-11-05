package com.finalProject.model.review;

import java.sql.Timestamp;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class ReviewDTO {

	private int review_no;
	private int product_no;
	private String member_id;
	private String review_title;
	private String review_content;
	private Timestamp register_date;
	private int review_like_count;
	private String review_type;
	private int review_ref;
	private String review_show;
	private int review_score;
	private Timestamp delivered_date;
	
	private String product_name;
	private String image_main_url;
//	private 
	
	
}
