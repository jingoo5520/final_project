package com.finalProject.service.admin;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.CancelCountDTO;
import com.finalProject.model.admin.CancelRevenueDTO;
import com.finalProject.model.admin.RevenueDTO;
import com.finalProject.model.admin.SaleCountDTO;

public interface AdminService {

	// 통계 데이터 가져오기
	Map<String, Object> getStatisticData() throws Exception;

	// 기간에 따른 가입자 수 가져오기
	int selectRangedMemberRegCnt(Timestamp regDate_start, Timestamp regDate_end) throws Exception;

	// 특정 달의 판매량 가져오기
	List<SaleCountDTO> getSalesByMonth(String selectedMonth) throws Exception;

	// 특정 달의 매출 가져오기
	List<RevenueDTO> getRevenuesByMonth(String selectedMonth) throws Exception;

	// 특정 달의 취소 수 가져오기 추가
	List<CancelCountDTO> getCancelByMonth(String selectedMonth) throws Exception;

	// 특정 달의 취소 가격 가져오기
	List<CancelRevenueDTO> getRevenueCancelByMonth(String selectedMonth) throws Exception;
}
