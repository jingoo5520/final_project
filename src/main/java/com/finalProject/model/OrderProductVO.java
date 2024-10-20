package com.finalProject.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class OrderProductVO {
	private String orderProductName;
	private int orderProductPrice;
	private String orderProductImg;
	private String orderDCType;
	private int orderDCAmount;
	private float orderDCRate;
	
}
