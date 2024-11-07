package com.finalProject.persistence.admin.statistics;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.statistics.AgeGroupSalesDTO;
import com.finalProject.model.admin.statistics.CateSalesDTO;
import com.finalProject.model.admin.statistics.GenderSalesDTO;
import com.finalProject.model.admin.statistics.PriceRangeDTO;

public interface StatisticsDAO {

	// 한 달 간의 총 매출 통계 조회
	int getTotalSalesThisMonth() throws Exception;
	int getTotalSalesLastMonth() throws Exception;
	int getTotalSalesLastYear() throws Exception;
	int getTotalSalesFirstHalfYear() throws Exception;
	int getTotalSalesSecondHalfYear() throws Exception;
	int getTotalSalesThisYear() throws Exception;

	// 오늘의 주문 개수
	int getTodayOrderCount() throws Exception;

	// 한 달 주문건수
	int getTotalOrdersThisMonth() throws Exception;

	// 이번 달 취소율
	double getCancelOrdersThisMonth() throws Exception;

	// 이번 달 반품율
	double getReturnOrdersThisMonth() throws Exception;

    // 카테고리별 매출 통계 메서드
    List<CateSalesDTO> getSalesByCategory() throws Exception;

    // 가격대별 매출 통계 메서드
    List<PriceRangeDTO> getSalesByPriceRange() throws Exception;

    // 연령별 매출 통계 메서드
    List<AgeGroupSalesDTO> getSalesByAgeGroup() throws Exception;

    // 성별별 매출 통계 메서드
	List<GenderSalesDTO> getSalesByGender() throws Exception;

//	// 방문자수
//	int getVisitorCount() throws Exception;



}
