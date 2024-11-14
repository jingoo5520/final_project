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
public class GenderSalesDTO {
    private String gender;       // "M", "F", "N" 값을 받기 위한 String 타입
    private Long total_sales;     // 합계 금액을 받기 위한 Long 타입
    
    // GenderSalesDTO 객체를 Map으로 변환하는 메서드 추가
    public Map<String, Object> toMap() {
        Map<String, Object> map = new HashMap<>();
        map.put("gender", gender);
        map.put("total_sales", total_sales);
        return map;
    }
}
