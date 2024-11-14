package com.finalProject.model.admin.product;

import java.util.List;

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
public class ProductVO {
	private int product_no;
	private String product_name;
	private int product_price;
	private String product_content;

	private String product_dc_type;
	private float dc_rate;
	private int product_sell_count;

	private List<ProductImg> list;
}
