package com.finalProject.model.admin.statistics;

import java.util.HashMap;
import java.util.Map;

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
@Builder
@ToString
public class PriceRangeDTO {
    private String priceRange;
    private Long total_sales;
    
    public Map<String, Object> toMap() {
        Map<String, Object> map = new HashMap<>();
        map.put("priceRange", this.priceRange);
        map.put("total_sales", this.total_sales);
        return map;
    }
    
}
