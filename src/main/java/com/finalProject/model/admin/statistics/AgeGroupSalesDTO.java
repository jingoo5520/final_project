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
public class AgeGroupSalesDTO {
    private String ageGroup;  // 연령대 (예: "20대", "30대", "40대", "50대 이상" 등)
    private Long total_sales;  // 해당 연령대의 총 매출
    
    // AgeGroupSalesDTO를 Map으로 변환
    public Map<String, Object> toMap() {
        Map<String, Object> map = new HashMap<>();
        map.put("ageGroup", ageGroup);
        map.put("total_sales", total_sales);
        return map;
    }
}
