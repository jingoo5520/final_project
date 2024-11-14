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
public class OrderProductVO {
	// 상품이름, 상품가격, 상품이미지, 상품할인정보
	private int productNo;
	private String productName;
	private int quantity;
	private int price;
	private String dcType;
	private float dcRate;
	private int dcAmount;
	private String productImg;
}
