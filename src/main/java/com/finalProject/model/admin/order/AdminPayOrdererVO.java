package com.finalProject.model.admin.order;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AdminPayOrdererVO {
	private int total_price_expected;
	private String orderer_id;
	private int use_point;
	private int coupon_no;
}
