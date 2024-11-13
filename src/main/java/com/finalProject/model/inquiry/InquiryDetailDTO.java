package com.finalProject.model.inquiry;

import java.sql.Timestamp;
import java.util.List;

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
public class InquiryDetailDTO {
	private int inquiry_no;
	private int product_no;
	private String product_name;
	private String member_id;
	private String member_name;
	private String inquiry_title;
	private String inquiry_content;
	private Timestamp inquiry_reg_date;
	private String inquiry_status;
	private String inquiry_type;
}

