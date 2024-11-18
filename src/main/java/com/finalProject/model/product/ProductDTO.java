package com.finalProject.model.product;

import java.sql.Date;
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
    private String image_url;
    private String image_type;
    private int review_count;
    
    private String category_name;
    
    private float average_score;

    // 할인 적용된 가격을 반환하는 메서드
    public int getCalculatedPrice() {
        if ("P".equalsIgnoreCase(product_dc_type)) {
            // 할인 타입이 P일 때: 할인율만큼 줄어든 금액 반환
        	return (int) (product_price * (1 - dc_rate));
        } else if ("N".equalsIgnoreCase(product_dc_type) || product_dc_type == null) {
            // 할인 타입이 'N'이거나 null인 경우 원가 반환
            return product_price;
        }
        return product_price; // 기본적으로 원가 반환
    }

	public void setCalculatedPrice(int calculatedPrice) {
		
	}

}
