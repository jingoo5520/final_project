package com.finalProject.model;

import java.sql.Timestamp;

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
public class UseCouponDTO {
	private int coupon_no;	// 쿠폰 번호
	private String coupon_code;	// 쿠폰 코드
	private String member;	// 회원 정보
	private String pay_date;	// 쿠폰 등록 날짜
	private String expire_date;	// 쿠폰 만료 날짜
	private int remaining_days;	// 남은 기한
	private String coupon_name;	// 쿠폰 이름
	private String coupon_dc_type;	// 할인 타입
	private int coupon_dc_amount;	// 할인 금액
	private float coupon_dc_rate;	// 할인 비율
}
