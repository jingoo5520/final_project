package com.finalProject.model.admin.coupon;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class PagingInfoNewDTO {
	private int pageNo;
	private int pagingSize; // 한 페이지에서 보여질 데이터의 개수
	private int pageCntPerBlock; // 한 블럭에서 보여질 페이지 개수
}
