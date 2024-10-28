package com.finalProject.model.admin.product;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductSearchDTO {
	private List<String> product_dc_type;
	private String searchType;
	private String product_name;
	private String reg_date_start;
	private String reg_date_end;
}
