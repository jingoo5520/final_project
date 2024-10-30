package com.finalProject.model.cart;

import com.finalProject.model.order.OrderMemberDTO;

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
public class CartMemberLevelDTO {
	// 장바구니를 조회한 회원의 등급 정보
	private String level_name;
	private float level_dc;
	private float level_point;
}
