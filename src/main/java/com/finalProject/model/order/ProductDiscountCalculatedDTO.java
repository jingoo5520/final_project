package com.finalProject.model.order;

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

// ProductDiscountDTO에 의해 개별 가격이 계산된 DTO
public class ProductDiscountCalculatedDTO {
	private int orderproduct_no;
	private int refundPrice = 0;
	private int refundPoint = 0;
	private double weight; // 가중치, DB에 저장되지 않음.
	private int remainedPrice; // 계산을 위해 임시로 저장하는 가격, DB에 저장되지 않음.
	private int remainedPoint; // 계산을 위해 임시로 저장하는 가격, DB에 저장되지 않음.
}
