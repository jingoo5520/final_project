package com.finalProject.persistence.admin.statistics;

import java.util.List;
import java.util.Map;

public interface StatisticsDAO {

	// 한 달 간의 총 매출 통계 조회
	int getTotalSalesLastMonth() throws Exception;

	// 오늘의 주문 개수
	int getTodayOrderCount() throws Exception;

	// 한 달 주문건수
	int getTotalOrdersThisMonth() throws Exception;

	// 이번 달 취소율
	double getCancelOrdersThisMonth() throws Exception;

	// 이번 달 반품율
	double getReturnOrdersThisMonth() throws Exception;

    // 카테고리별 매출 통계 메서드 추가
    List<Map<String, Object>> getSalesByCategory() throws Exception;

    // 가격대별 매출 통계 메서드 추가
    List<Map<String, Object>> getSalesByPriceRange() throws Exception;

    // 연령별 매출 통계 메서드 추가
    List<Map<String, Object>> getSalesByAgeGroup() throws Exception;


}
