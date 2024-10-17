package com.finalProject.controller.product;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@GetMapping("/productList")
	public String productListPage(Locale locale, Model model) {
		return "/user/product/productList";
	}
	
	@GetMapping("/productDetail")
	public String productDetailPage(Locale locale, Model model) {
		return "/user/product/productDetail";
	}
	

}
