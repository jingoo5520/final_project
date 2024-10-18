package com.finalProject.service;

import java.util.List;

import com.finalProject.model.ProductDTO;

public interface ProductService {

	int saveProduct(ProductDTO productDTO, List<String> list);

}
