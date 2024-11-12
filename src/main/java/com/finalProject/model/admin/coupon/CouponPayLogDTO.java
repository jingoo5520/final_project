package com.finalProject.model.admin.coupon;

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
public class CouponPayLogDTO {
	private int coupon_paid_no;
	private int coupon_no;
	private String coupon_name;
	private String coupon_code;
	private String member;
	private Timestamp pay_date;
	private Timestamp expire_date;
}
