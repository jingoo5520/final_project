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
public class OrderProductsDTO {
	private String orderDate; // 예 : "2024.10.01"
	private String orderId;
	private String orderStatus; // 예 : "배송완료"
	private String payMethod;
	private List<OrderProductDTO> products; // productName과 imageMainURL만 사용할 것이다.
}
