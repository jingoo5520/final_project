package com.finalProject.model.product;

import java.sql.Date;
import java.util.List;

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
public class ProductDTO {
	
    private int product_no;
    private String product_name;
    private int product_stock_count;
    private int product_price;
    private String product_dc_type;
    private float dc_rate;
    private int dc_amount;
    private int product_sell_count;
    private String product_content;
    private int product_like;
    private Date product_reg_date;
    private int product_category;
    private int product_cost;
    private String product_delete;
    private String product_show;
    private String image_main_url;
    private String image_sub_url;
    
    private String category_name;

}
