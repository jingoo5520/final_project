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
public class OrderMemberDTO {
	// 주문자 이름, 휴대폰, 이메일, 주소, 포인트 정보, 등급 정보
	private String member_id;
	private String member_name;
	private String phone_number;
	private String email;
	private String address;
	private int member_point;
	private String level_name;
	private float level_dc;
	private float level_point;
	private String delivery_address;
	private String delivery_name;
}
