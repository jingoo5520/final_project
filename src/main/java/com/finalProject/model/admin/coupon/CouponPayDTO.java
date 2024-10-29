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
public class CouponPayDTO {
	private int coupon_no;
	private String coupon_code;
	private String member;
	private Timestamp expire_date;
}
