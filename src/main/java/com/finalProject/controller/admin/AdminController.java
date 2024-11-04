package com.finalProject.controller.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.finalProject.service.admin.statistics.StatisticsService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private StatisticsService statisticsService; // 통계 데이터를 처리하는 서비스

    @GetMapping
    public String getAllStatistics(Model model) {
        System.out.println("admin statistics...");

        try {
            // 통계 데이터 조회 및 모델에 추가
            addStatisticToModel(model, "totalSales", statisticsService.getTotalSalesLastMonth(), "총 매출 (지난 한 달): {}");
            addStatisticToModel(model, "todayOrderCount", statisticsService.getTodayOrderCount(), "오늘의 주문 개수: {}");
            addStatisticToModel(model, "totalOrders", statisticsService.getTotalOrdersThisMonth(), "이번 달 주문 개수: {}");
            addStatisticToModel(model, "cancelRate", statisticsService.getCancelOrdersThisMonth(), "이번 달 취소율: {}");
            addStatisticToModel(model, "returnRate", statisticsService.getReturnOrdersThisMonth(), "이번 달 반품율: {}");

            // 카테고리별 매출 통계 조회 및 모델에 추가
            List<Map<String, Object>> salesByCategory = statisticsService.getSalesByCategory();
            model.addAttribute("salesByCategory", salesByCategory);
            log.info("카테고리별 매출 통계: {}", salesByCategory);
            
            // 연령별 매출 통계 가져오기
            List<Map<String, Object>> salesByAgeGroup = statisticsService.getSalesByAgeGroup();
            model.addAttribute("salesByAgeGroup", salesByAgeGroup);
            log.info("연령별 매출 통계: {}", salesByAgeGroup);
            
        } catch (Exception e) {
            log.error("통계 조회 중 오류 발생: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "통계 조회 중 오류가 발생했습니다. 나중에 다시 시도해 주세요.");
            return "error"; // 오류 페이지로 리턴
        }

        return "admin/index"; // JSP 뷰의 경로를 지정
    }


	// 공통적인 통계 데이터 추가 및 로그 메서드
    private void addStatisticToModel(Model model, String attributeName, Object value, String logMessage) {
        model.addAttribute(attributeName, value);
//        log.info(logMessage, value);
    }
}
