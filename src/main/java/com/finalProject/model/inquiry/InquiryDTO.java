package com.finalProject.model.inquiry;

import java.sql.Timestamp;

import com.finalProject.model.admin.coupon.CouponDTO;

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
public class InquiryDTO {
	private int inquiry_no;
	private String member_id;
	private String inquiry_title;
	private Timestamp inquiry_reg_date;
	private String inquiry_status;
}

