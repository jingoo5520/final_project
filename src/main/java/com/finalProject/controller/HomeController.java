package com.finalProject.controller;

import java.util.Locale;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@GetMapping("/admin")
	public String adminPage() {
		System.out.println("to admin index page");
		// return "/admin/index";
		return "/admin/index";
	}
	
	
	@GetMapping("/admin/coupon")
	public String couponPage() {
		return "/admin/pages/coupon";
	}
}
