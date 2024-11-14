package com.finalProject.model.cart;

import lombok.Setter;
import lombok.ToString;
import lombok.Getter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class CartDTO {
	private int cart_item_no;
	private int cart_no;
	private int product_count;
	private int product_no;
	private String product_name;
	private int product_price;
	
	@Builder.Default
	private String image_url = null;
	
	private String product_dc_type;
	private float dc_rate;
	private String category_name;
}
