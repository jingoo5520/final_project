package com.finalProject.controller.order;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderController {
	
	@GetMapping("/order")
	public String homePage(Locale locale, Model model) {
		return "/user/order/order";
	}
}
