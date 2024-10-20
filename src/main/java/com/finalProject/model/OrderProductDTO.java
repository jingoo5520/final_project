package com.finalProject.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class OrderProductDTO {
	int product_no;
	String product_name;
	int product_price;
	String product_dc_type;
	int dc_amount;
	float dc_rate;
}
