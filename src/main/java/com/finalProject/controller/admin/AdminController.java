package com.finalProject.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	// 관리자 페이지 이동
	@GetMapping("")
	public String adminPage() {
		System.out.println("to admin index page");
		return "/admin/index";
	}
}
