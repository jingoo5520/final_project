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
public class CateSalesDTO {
	private String category;
	private double total_sales;
	
    // CateSalesDTO 객체를 Map으로 변환하는 메서드 추가
    public Map<String, Object> toMap() {
        Map<String, Object> map = new HashMap<>();
        map.put("category", category);
        map.put("total_sales", total_sales);
        return map;
    }
}
