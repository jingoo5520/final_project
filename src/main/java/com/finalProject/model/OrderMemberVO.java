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
public class OrderMemberVO {
	private String name;
	private String phoneNumber;
	private String email;
	private String address;
	private String point;
	private String levelName;
	private String levelDC;
	private String levelPoint;
}
