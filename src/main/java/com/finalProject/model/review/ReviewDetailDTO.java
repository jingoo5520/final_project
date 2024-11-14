package com.finalProject.model.review;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

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
public class ReviewDetailDTO {

	private int review_no;
	private int product_no;
	private String member_id;
	private String review_title;
	private String review_content;
	private Timestamp register_date;
	private int review_score;
	
	private String product_name;
	private String product_image_url;
	private String review_image_url;
	private String nickname;

	
	
}
