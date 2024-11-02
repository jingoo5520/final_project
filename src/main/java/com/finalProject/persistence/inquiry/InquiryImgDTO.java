package com.finalProject.persistence.inquiry;

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
public class InquiryImgDTO {
	private int inquiry_image_no;
	private int inquiry_no;
	private String base64Img;
	private String path;
}
