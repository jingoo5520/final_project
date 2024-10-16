package com.finalProject.controller;

import java.util.Locale;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@GetMapping("/")
	public String homePage(Locale locale, Model model) {
		return "user/index";
	}
	
	@GetMapping("/admin")
	public void adminPage() {
		System.out.println("admin");
	}
	
	@GetMapping("/order")
	public String orderPage(Locale locale, Model model) {
		return "order";
	}
}
