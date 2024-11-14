package com.finalProject.model.cart;

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
public class CookieCartVO {
	private int product_count;
	private int product_no;
	private String product_name;
	private int product_price;
	private String image_url;
	private String product_dc_type;
	private float dc_rate;
	private String category_name;
}
