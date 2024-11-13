package com.finalProject.model.home;

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
@Getter
@Setter
@ToString
public class HomeProductDTO {
	private int product_no;
	private String product_name;
	private int product_price;
	private String category_name;
	private String image_url;
}
