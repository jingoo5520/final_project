package com.finalProject.model.admin.review;

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
public class ReviewReplyDTO {
	private int review_no;
	private int review_ref;
	private String review_title;
	private String review_content;
	private int product_no;
	private String member_id;
}
