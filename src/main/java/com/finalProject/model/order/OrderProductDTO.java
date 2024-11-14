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
	private String cancel_status;
	private int orderproduct_no;
	private int product_no;
	private String product_name;
	private int quantity;
	private int product_price;
	private String product_dc_type;
	private float dc_rate;
	private String image_url = null;
}
