package com.finalProject.model;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@ToString
@Getter
@Setter
public class ResponseData {
	private String status;
	private String value;
	private int[] product_id; // 찜목록 배열 저장용
	
	public ResponseData(String status, String value) {
		this.status = status;
		this.value = value;
		this.product_id = new int[0];
	}
	
}
