package com.finalProject.model.admin.inquiry;

import java.sql.Timestamp;

import com.finalProject.model.inquiry.InquiryDetailDTO;

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
public class InquiryReplyDTO {
	private int inquiry_reply_no;
	private int inquiry_no;
	private String reply_content;
	private Timestamp reply_reg_date;
	private String admin_id;
}

