
package com.finalProject.controller.admin.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.finalProject.service.admin.product.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j

@RestController("/rest/productGet")
public class ProductRestController {

	@Autowired
	private ProductService ps;

//	@GetMapping
//	public List<ProductDTO> getAllProducts(Model model) {
//		List<ProductDTO> productList = ps.getAllProducts();
//		return productList;
//	}
}
