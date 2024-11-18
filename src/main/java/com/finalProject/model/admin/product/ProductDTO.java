package com.finalProject.model.admin.product;

import org.springframework.web.multipart.MultipartFile;

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
public class ProductDTO {
	private int product_no;
	private String product_name;
	private int product_price;
	private String product_content;
	private int category_no;
	private String product_dc_type;
	private float dc_rate;
	private int product_sell_count;
	private String product_show;
	private int product_stock_count;

	private MultipartFile product_content_file;
	private MultipartFile image_main_url;
	private MultipartFile[] image_sub_url;
}
