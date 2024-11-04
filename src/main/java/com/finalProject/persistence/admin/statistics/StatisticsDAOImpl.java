package com.finalProject.persistence.admin.statistics;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Mapper
@Repository
public class StatisticsDAOImpl implements StatisticsDAO {

	@Autowired
	private SqlSession ses;
	
	private String ns = "com.finalProject.mappers.statisticsMapper.";

	@Override
	public int getTotalSalesLastMonth() throws Exception {
	    try {
	        Integer totalSales = ses.selectOne(ns + "getTotalSalesLastMonth");
	        totalSales = (totalSales != null) ? totalSales : 0; // null 처리
	        log.info("지난 한 달간의 총 매출 금액: " + totalSales);
	        return totalSales;
	    } catch (Exception e) {
	        log.error("총 매출 조회 중 오류 발생", e);
	        throw e; // 예외 던져
	    }
	}

	@Override
	public int getTodayOrderCount() throws Exception {
	    try {
	        Integer orderCount = ses.selectOne(ns + "getTodayOrderCount");
	        orderCount = (orderCount != null) ? orderCount : 0; // null 처리
	        log.info("오늘의 주문 개수: " + orderCount);
	        return orderCount;
	    } catch (Exception e) {
	        log.error("오늘의 주문 개수 조회 중 오류 발생", e);
	        throw e; // 예외 던져
	    }
	}

	@Override
	public int getTotalOrdersThisMonth() throws Exception {
	    try {
	        Integer orderCount = ses.selectOne(ns + "getTotalOrdersThisMonth");
	        orderCount = (orderCount != null) ? orderCount : 0; // null 처리
	        log.info("이번 달의 주문 개수: " + orderCount);
	        return orderCount;
	    } catch (Exception e) {
	        log.error("이번 달의 주문 개수 조회 중 오류 발생", e);
	        throw e; // 예외 던져
	    }
	}

    @Override
    public double getCancelOrdersThisMonth() throws Exception {
        try {
            Double cancelRate = ses.selectOne(ns + "getCancelOrdersThisMonth");
            cancelRate = (cancelRate != null) ? cancelRate : 0.0; // null 처리
            log.info("이번 달의 취소율: " + cancelRate);
            return cancelRate;
        } catch (Exception e) {
            log.error("이번 달의 취소율 조회 중 오류 발생", e);
            throw e; // 예외 던져
        }
    }

    @Override
    public double getReturnOrdersThisMonth() throws Exception {
        try {
            Double returnRate = ses.selectOne(ns + "getReturnOrdersThisMonth");
            returnRate = (returnRate != null) ? returnRate : 0.0; // null 처리
            log.info("이번 달의 반품율: " + returnRate);
            return returnRate;
        } catch (Exception e) {
            log.error("이번 달의 반품율 조회 중 오류 발생", e);
            throw e; // 예외 던져
        }
    }

    @Override
    public List<Map<String, Object>> getSalesByCategory() throws Exception {
        try {
            // MyBatis를 통해 카테고리별 매출 통계 조회
            List<Map<String, Object>> salesByCategory = ses.selectList(ns + "getSalesByCategory");
            log.info("카테고리별 매출 통계 조회 성공, 데이터 개수: {}", salesByCategory.size());
            
            // 결과가 없을 경우 처리
            if (salesByCategory.isEmpty()) {
                log.warn("카테고리별 매출 통계 데이터가 없습니다.");
            }
            
            return salesByCategory;
        } catch (DataAccessException e) { // 데이터 접근 예외
            log.error("카테고리별 매출 통계 조회 중 데이터 접근 오류 발생", e);
            throw e; // 예외 던져
        } catch (Exception e) {
            log.error("카테고리별 매출 통계 조회 중 오류 발생", e);
            throw e; // 예외 던져
        }
    }


    @Override 
    public List<Map<String, Object>> getSalesByPriceRange() throws Exception {
        try {
            List<Map<String, Object>> salesByPriceRange = ses.selectList(ns + "getSalesByPriceRange");
            log.info("가격대별 매출 통계 조회 성공");
            return salesByPriceRange;
        } catch (Exception e) {
            log.error("가격대별 매출 통계 조회 중 오류 발생", e);
            throw e; // 예외 던져
        }
    }

    @Override
    public List<Map<String, Object>> getSalesByAgeGroup() {
        return ses.selectList(ns + "getSalesByAgeGroup");
    }




}
