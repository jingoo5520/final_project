package com.finalProject.controller.admin.inquiry;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.service.admin.inquiry.AdminInquiryService;

@Controller
@RequestMapping("/admin/inquiry")
public class AdminInquiryController {

	@Inject
	AdminInquiryService aiService;

	// 문의 페이지 이동
	@GetMapping("/adminInquiries")
	public String inquiryPage(Model model, HttpServletRequest request) {
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			data = aiService.getInquiryList(new PagingInfoNewDTO(1, 5, 10));
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(data);

		model.addAttribute("inquiryData", data);

		return "/admin/pages/inquiry/adminInquiries";
	}
	
	// 문의 리스트 가져오기
		@GetMapping("/getInquiries")
		@ResponseBody
		public Map<String, Object> getInquiries(@RequestParam int pageNo, @RequestParam int pagingSize,
				@RequestParam int pageCntPerBlock) {
			Map<String, Object> data = new HashMap<String, Object>();

			try {
				data = aiService.getInquiryList(new PagingInfoNewDTO(pageNo, pagingSize, pageCntPerBlock));
			} catch (Exception e) {
				e.printStackTrace();
			}

			return data;
		}
}
