package com.finalProject.model.order;

import java.util.List;

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
public class ProductDiscountDTO {
	private int orderproduct_no;
	private int productPrice; // 할인이 하나도 적용되지 않은 상품의 가격
	private int orderCount; // 주문한 상품의 개수
	
	//======================================================================================  
	// 개별상품별 퍼센트 할인
	// orderproduct_no마다 다를 수 있음
	// 예) orderproduct_no = 1일때 discountByItem = 0.03,
	// 	   orderproduct_no = 2일때 discountByItem = 0.05
	//======================================================================================  
	private float discountByItem;
	//======================================================================================  
	// 전체상품의 쿠폰 절대값 할인량
	// 예를 들어서 5000원 할인 쿠폰을 사용했다면
	// sumDiscountByCoupon = 5000
	// NOTE : 쿠폰은 한 주문에 하나만 적용 가능하다고 가정했음.
	//======================================================================================  
	private int sumDiscountByCoupon; 
	//======================================================================================  
	// 전체상품의 쿠폰 퍼센티지 할인량
	// 예를 들어서 7%원 할인 쿠폰을 사용했다면
	// multipliedDiscountByCoupon = 0.07
	// NOTE : 쿠폰은 한 주문에 하나만 적용 가능하다고 가정했음.
	//======================================================================================  
	private float multipliedDiscountByCoupon;
	//======================================================================================  
	// 전체상품의 등급 퍼센티지 할인량
	// 예를 들어서 회원이 골드 등급인 경우에는
	// multipliedDiscountByMemberLevel = 0.05
	//======================================================================================
	private float multipliedDiscountByMemberLevel;
	//======================================================================================  
	// 전체상품의 포인트 할인량
	// 예를 들어서 10000 포인트를 사용했다면
	// sumDiscountByPoint = 10000
	//======================================================================================  
	private int sumDiscountByPoint;
}
