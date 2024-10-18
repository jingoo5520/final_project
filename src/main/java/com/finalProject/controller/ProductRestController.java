package com.finalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.finalProject.model.ProductDTO;
import com.finalProject.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController("/rest/product")
public class ProductRestController {
	@Autowired
	private ProductService ps;

	@GetMapping
	public List<ProductDTO> getAllProducts(Model model) {
		List<ProductDTO> productList = ps.getAllProducts();
		return productList;
	}
}
