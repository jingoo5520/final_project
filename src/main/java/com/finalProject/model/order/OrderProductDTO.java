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
public class OrderProductDTO {
	private String product_name;
	private int product_price;
	private String product_dc_type;
	private float dc_rate;
	private int dc_amount;
	private String image_main_url;
}
