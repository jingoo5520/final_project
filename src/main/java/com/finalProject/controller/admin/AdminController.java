package com.finalProject.controller.admin;

import java.util.ArrayList;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.service.admin.AdminService;

import com.finalProject.model.admin.statistics.AgeGroupSalesDTO;
import com.finalProject.model.admin.statistics.CateSalesDTO;
import com.finalProject.model.admin.statistics.GenderSalesDTO;
import com.finalProject.model.admin.statistics.PriceRangeDTO;
import com.finalProject.service.admin.statistics.StatisticsService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private StatisticsService statisticsService; // 통계 데이터를 처리하는 서비스

	@Inject
	AdminService aService;

	// 관리자 페이지 이동
	@GetMapping("")
	public String adminPage(Model model) {
		return "/admin/index";
	}

	// 통계 데이터 가져오기
	@GetMapping("/getStatisticData")
	@ResponseBody
	public Map<String, Object> getStatisticData() {
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			data = aService.getStatisticData();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return data;
	}
	
	// 기간에 따른 가입자 수 가져오기
	@GetMapping("/getMemberRegCnt")
	@ResponseBody
	public int getMemberRegCnt(@RequestParam Timestamp regDate_start, @RequestParam Timestamp regDate_end) {
		int data = 0;

		System.out.println(regDate_start);
		System.out.println(regDate_end);
		
		try {
			data = aService.getMemberRegCnt(regDate_start, regDate_end);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data;
	}
	
//    @GetMapping
//	public String viewStatistics(Model model) {
//        try {
//            // 매출
//            model.addAttribute("totalSales", statisticsService.getTotalSalesThisMonth()); // 이번 달
//            model.addAttribute("lastMonthSales", statisticsService.getTotalSalesLastMonth()); // 지난 달
//            model.addAttribute("lastYearSales", statisticsService.getTotalSalesLastYear()); // 작년
//            model.addAttribute("firstHalfSales", statisticsService.getTotalSalesFirstHalfYear()); // 상반기
//            model.addAttribute("secondHalfSales", statisticsService.getTotalSalesSecondHalfYear()); // 하반기
//            model.addAttribute("thisYearSales", statisticsService.getTotalSalesThisYear()); // 올해
//            
//            
//            // 방문자수
////            model.addAttribute("visitorCount", statisticsService.getVisitorCount());
//            
//            // 주문수
//            model.addAttribute("todayOrderCount", statisticsService.getTodayOrderCount());
//            model.addAttribute("totalOrders", statisticsService.getTotalOrdersThisMonth());
//            
//            // 취소율
//            model.addAttribute("cancelRate", statisticsService.getCancelOrdersThisMonth());
//            // 반품율
//            model.addAttribute("returnRate", statisticsService.getReturnOrdersThisMonth());
//            
//            log.info("기본 통계 데이터 추가 완료");
//
//        } catch (Exception e) {
//            log.error("통계 조회 중 오류 발생: {}", e.getMessage(), e);
//            model.addAttribute("errorMessage", "통계 조회 중 오류가 발생했습니다. 나중에 다시 시도해 주세요.");
//        }
//
//        return "admin/index"; // JSP 경로
//    }
//	
//	@GetMapping("/statistics")
//	@ResponseBody
//    public Map<String, Object> getStatisticsData() {
//        Map<String, Object> statisticsData = new HashMap<>();
//
//        try {
//            // 카테고리별
//            List<CateSalesDTO> salesByCategory = statisticsService.getSalesByCategory();
//            List<Map<String, Object>> categoryMapList = new ArrayList<>();
//            for (CateSalesDTO cateSalesDTO : salesByCategory) {
//                categoryMapList.add(cateSalesDTO.toMap());  // DTO를 Map으로 변환하여 추가
//            }
//            statisticsData.put("salesByCategory", categoryMapList);
//            for (CateSalesDTO cateSalesDTO : salesByCategory) {
//                log.info(cateSalesDTO.toString());
//            }
//            
//            // 가격대별
//            List<PriceRangeDTO> salesByPriceRange = statisticsService.getSalesByPriceRange();
//            statisticsData.put("salesByPriceRange", salesByPriceRange);
//            for (PriceRangeDTO priceRangeDTO : salesByPriceRange) {
//                log.info(priceRangeDTO.toString());
//            }
//
//            // 연령대별
//            List<AgeGroupSalesDTO> salesByAgeGroup = statisticsService.getSalesByAgeGroup();
//            List<Map<String, Object>> ageGroupMapList = new ArrayList<>();
//            for (AgeGroupSalesDTO ageGroupSalesDTO : salesByAgeGroup) {
//                ageGroupMapList.add(ageGroupSalesDTO.toMap());  // DTO를 Map으로 변환하여 추가
//            }
//            statisticsData.put("salesByAgeGroup", ageGroupMapList);
//            for (AgeGroupSalesDTO ageGroupSalesDTO : salesByAgeGroup) {
//                log.info(ageGroupSalesDTO.toString());
//                
//            }
//            log.info("Sales by Age Group: {}", salesByAgeGroup);
//
//            // 성별별
//            List<GenderSalesDTO> salesByGender = statisticsService.getSalesByGender();
//            List<Map<String, Object>> genderMapList = new ArrayList<>();
//            for (GenderSalesDTO genderSalesDTO : salesByGender) {
//                genderMapList.add(genderSalesDTO.toMap());  // DTO를 Map으로 변환하여 추가
//            }
//            statisticsData.put("salesByGender", genderMapList);
//            for (GenderSalesDTO genderSalesDTO : salesByGender) {
//                log.info(genderSalesDTO.toString());
//            }
//            
////            // 직접 세팅할 값 추가 (ageGroup, priceRange)
////            Map<String, Object> additionalData = new HashMap<>();
////            additionalData.put("ageGroup", new String[]{"10대", "20대", "30대", "40대", "50대", "60대", "70대", "80대", "90대 이상"});
////            additionalData.put("priceRange", new String[]{
////                "0-100000", "100001-200000", "200001-300000", "300001-400000", "400001-500000", "500001-600000",
////                "600001-700000", "700001-800000", "800001-900000", "900001-1000000", "1000001 이상"
////            });
//
////            statisticsData.put("additionalData", additionalData);
//
//            log.info("통계 데이터 JSON 형식으로 반환 성공");
//
//        } catch (Exception e) {
//            log.error("통계 조회 중 오류 발생: {}", e.getMessage(), e);
//            statisticsData.put("errorMessage", "통계 조회 중 오류가 발생했습니다. 나중에 다시 시도해 주세요.");
//        }
//        
//        return statisticsData;
//    }

}


//	// 공통적인 통계 데이터 추가 및 로그 메서드
//    private void addStatisticToModel(Model model, String attributeName, Object value, String logMessage) {
//        model.addAttribute(attributeName, value);
////        log.info(logMessage, value);
//    }
