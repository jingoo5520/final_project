package com.finalProject.model.admin.coupon;

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
public class CouponDTO {
	private int coupon_no;
	private String coupon_name;
	private String coupon_dc_type;
	private int coupon_dc_amount;
	private float coupon_dc_rate;
	private int coupon_use_days;
}
