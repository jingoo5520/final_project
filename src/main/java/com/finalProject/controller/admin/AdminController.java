package com.finalProject.controller.admin;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.CancelCountDTO;
import com.finalProject.model.admin.CancelRevenueDTO;
import com.finalProject.model.admin.RevenueDTO;
import com.finalProject.model.admin.SaleCountDTO;
import com.finalProject.service.admin.AdminService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Inject
	AdminService aService;

	// 관리자 페이지 이동
	@GetMapping("")
	public String adminPage(Model model) {
		return "/admin/index";
	}

	// 에러페이지 실행용 제거
	@GetMapping("/testException")
	public String testException() {
		throw new RuntimeException("예외가 발생했네요");
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
	@GetMapping("/selectRangedMemberRegCnt")
	@ResponseBody
	public int selectRangedMemberRegCnt(@RequestParam Timestamp regDate_start, @RequestParam Timestamp regDate_end) {
		int data = 0;

		try {
			data = aService.selectRangedMemberRegCnt(regDate_start, regDate_end);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data;
	}

	// 특정 달의 카테고리별 판매량 가져오기
	@GetMapping("/getSalesByMonth")
	@ResponseBody
	public Map<String, Object> getSalesByMonth(@RequestParam("month") String selectedMonth) {
		List<SaleCountDTO> data = null;
		// 추가
		List<CancelCountDTO> data2 = null;
		// 추가
		Map<String, Object> responseMap = new HashMap<>();
		try {
			data = aService.getSalesByMonth(selectedMonth);
			// 추가
			data2 = aService.getCancelByMonth(selectedMonth);
			responseMap.put("sales", data);
			responseMap.put("cancels", data2);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return responseMap;
	}

	// 특정 달의 카테고리별 매출 가져오기
	@GetMapping("/getRevenuesByMonth")
	@ResponseBody
	public Map<String, Object> getRevenuesByMonth(@RequestParam("month") String selectedMonth) {
		List<RevenueDTO> data = null;
		List<CancelRevenueDTO> data2 = null;
		Map<String, Object> responseMap = new HashMap<>();
		try {
			data = aService.getRevenuesByMonth(selectedMonth);
			data2 = aService.getRevenueCancelByMonth(selectedMonth);
			System.out.println(data);
			System.out.println(data2);
			responseMap.put("revenue", data);
			responseMap.put("cancelRevenue", data2);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return responseMap;
	}

}
