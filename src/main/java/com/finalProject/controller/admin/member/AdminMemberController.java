package com.finalProject.controller.admin.member;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.MemberSearchFilterDTO;
import com.finalProject.model.admin.PagingInfoDTO;
import com.finalProject.service.admin.member.AdminMemberService;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {

	@Inject
	AdminMemberService amService;

	// 회원 전체 조회
	@GetMapping("/getAllMembers")
	@ResponseBody
	public Map<String, Object> getAllMembers(@RequestParam int pageNo, @RequestParam int pagingSize,
			@RequestParam int pageCntPerBlock) {

		String result = "";
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			result = "success";
			data = amService.getAllMembers(new PagingInfoDTO(pageNo, pagingSize, pageCntPerBlock));
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return data;
	}

	// 회원 필터링 조회
	@PostMapping("/getFilteredMembers")
	@ResponseBody
	public Map<String, Object> getFilteredMembers(@ModelAttribute MemberSearchFilterDTO dto) {

		
		String result = "";
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			result = "success";
			data = amService.getFilteredMembers(dto);
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return data;
	}

}