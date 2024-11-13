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

import com.finalProject.service.admin.AdminService;

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
	
	

}
