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
public class ReviewImgDTO {
	private int inquiry_image_no;
	private int inquiry_no;
	private String image_url;
}
