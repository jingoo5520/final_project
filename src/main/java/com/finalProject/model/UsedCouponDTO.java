package com.finalProject.model;

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
public class UsedCouponDTO {
	private String coupon_name;
	private String coupon_dc_type;
	private int coupon_dc_amount;
	private float coupon_dc_rate;
	private String member;
	private String use_date; 
}
