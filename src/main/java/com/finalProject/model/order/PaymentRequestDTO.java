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
public class PaymentRequestDTO {
	private List<OrderRequestDTO> productsInfo; // 상품번호 + 수량 정보 리스트
    private String paymentType; // 결제 방법
    private String saveDeliveryType; // 배송지 저장 구분
    private String deliveryName; // 배송지 이름
    private String deliveryAddress; // 배송지 주소
    private String deliveryRequest; // 배송 요청사항
    private String ordererId; // 주문자 ID
    private String ordererName; // 주문자 이름
    private String phoneNumber; // 주문자 전화번호
    private String email; // 주문자 이메일
    private int pointDC; // 사용 포인트
    private String couponUse; // 사용 쿠폰코드
}
