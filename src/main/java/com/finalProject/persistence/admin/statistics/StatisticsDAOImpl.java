package com.finalProject.persistence.admin.statistics;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.statistics.AgeGroupSalesDTO;
import com.finalProject.model.admin.statistics.CateSalesDTO;
import com.finalProject.model.admin.statistics.GenderSalesDTO;
import com.finalProject.model.admin.statistics.PriceRangeDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Mapper
@Repository
public class StatisticsDAOImpl implements StatisticsDAO {

	@Autowired
	private SqlSession ses;
	
	private String ns = "com.finalProject.mappers.statisticsMapper.";

	@Override
	public int getTotalSalesThisMonth() throws Exception {
	    try {
	        Integer totalSales = ses.selectOne(ns + "getTotalSalesThisMonth");
	        totalSales = (totalSales != null) ? totalSales : 0; // null 처리
	        log.info("이번 달 한 달간의 총 매출 금액: " + totalSales);
	        return totalSales;
	    } catch (Exception e) {
	        log.error("총 매출 조회 중 오류 발생", e);
	        throw e; // 예외 던져
	    }
	}
	
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
	public int getTotalSalesLastYear() throws Exception {
	    try {
	        Integer totalSales = ses.selectOne(ns + "getTotalSalesLastYear");
	        totalSales = (totalSales != null) ? totalSales : 0; // null 처리
	        log.info("작년 총 매출 금액: " + totalSales);
	        return totalSales;
	    } catch (Exception e) {
	        log.error("총 매출 조회 중 오류 발생", e);
	        throw e; // 예외 던져
	    }
	}

	@Override
	public int getTotalSalesFirstHalfYear() throws Exception {
	    try {
	        Integer totalSales = ses.selectOne(ns + "getTotalSalesFirstHalfYear");
	        totalSales = (totalSales != null) ? totalSales : 0; // null 처리
	        log.info("상반기 (1~6) 총 매출 금액: " + totalSales);
	        return totalSales;
	    } catch (Exception e) {
	        log.error("총 매출 조회 중 오류 발생", e);
	        throw e; // 예외 던져
	    }
	}

	@Override
	public int getTotalSalesSecondHalfYear() throws Exception {
	    try {
	        Integer totalSales = ses.selectOne(ns + "getTotalSalesSecondHalfYear");
	        totalSales = (totalSales != null) ? totalSales : 0; // null 처리
	        log.info("하반기 (7~12) 총 매출 금액: " + totalSales);
	        return totalSales;
	    } catch (Exception e) {
	        log.error("총 매출 조회 중 오류 발생", e);
	        throw e; // 예외 던져
	    }
	}

	@Override
	public int getTotalSalesThisYear() throws Exception {
	    try {
	        Integer totalSales = ses.selectOne(ns + "getTotalSalesThisYear");
	        totalSales = (totalSales != null) ? totalSales : 0; // null 처리
	        log.info("올해 총 매출 금액: " + totalSales);
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
    public List<CateSalesDTO> getSalesByCategory() throws Exception {
        try {
            // MyBatis를 통해 카테고리별 매출 통계 조회
            List<CateSalesDTO> salesByCategory = ses.selectList(ns + "getSalesByCategory");
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

//    @Override
//    public List<PriceRangeDTO> getSalesByPriceRange() throws Exception {
//        List<Map<String, Object>> mapList = new ArrayList<>();
//
//        try {
//            // DB에서 직접 매출 계산
//            List<PriceRangeDTO> resultList = ses.selectList(ns + "getTotalSalesByPriceRange");
//
//            // PriceRangeDTO 객체를 Map으로 변환하여 추가
//            for (PriceRangeDTO dto : resultList) {
//                mapList.add(dto.toMap());
//            }
//        } catch (Exception e) {
//            log.error("가격대별 매출 조회 중 오류 발생", e);
//            throw new RuntimeException("가격대별 매출 조회 중 오류 발생", e);
//        }
//
//        return mapList;
//    }
    
    @Override
    public List<PriceRangeDTO> getSalesByPriceRange() throws Exception {
        // DB에서 매출 데이터 조회
        List<PriceRangeDTO> resultList = new ArrayList<>();

        try {
            // DB에서 직접 매출 계산
            resultList = ses.selectList(ns + "getTotalSalesByPriceRange");
        } catch (Exception e) {
            log.error("가격대별 매출 조회 중 오류 발생", e);
            throw new RuntimeException("가격대별 매출 조회 중 오류 발생", e);
        }

        return resultList; // List<PriceRangeDTO> 객체 반환
    }

    @Override
    public List<GenderSalesDTO> getSalesByGender() throws Exception {
        try {
            List<GenderSalesDTO> genderSales = ses.selectList(ns + "getSalseByGender");
            log.info("성별별 매출 조회 결과: {}", genderSales);
            return genderSales;
        } catch (Exception e) {
            log.error("성별별 매출 조회 중 오류 발생", e);
            throw e;
        }
    }

    @Override
    public List<AgeGroupSalesDTO> getSalesByAgeGroup() {
        try {
            List<AgeGroupSalesDTO> ageSales = ses.selectList(ns + "getSalesByAgeGroup");
            log.info("연령대별 매출 조회 결과: {}", ageSales);
            return ageSales;
        } catch (Exception e) {
            log.error("연령대별 매출 조회 중 오류 발생", e);
            throw e;
        }
    }


//	@Override
//	public int getVisitorCount() throws Exception {
//	    try {
//	        Integer visitorCount = ses.selectOne(ns + "getVisitorCount");
//	        visitorCount = (visitorCount != null) ? visitorCount : 0; // null 처리
//	        log.info("방문자 수: " + visitorCount);
//	        return visitorCount;
//	    } catch (Exception e) {
//	        log.error("방문자 수 조회 중 오류 발생", e);
//	        throw e; // 예외 던져
//	    }
//	}






}
