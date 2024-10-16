package com.finalProject.controller.cart;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CartController {
	@GetMapping("/cart")
	public String cartPage(Locale locale, Model model) {
		return "user/cart/cart";
	}
}
