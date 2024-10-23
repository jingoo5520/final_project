package com.finalProject.service;

import java.util.List;

import com.finalProject.model.ProductDTO;
import com.finalProject.model.ProductUpdateDTO;

public interface ProductService {

	int saveProduct(ProductDTO productDTO, List<String> list);

	List<ProductDTO> getAllProducts();

	int updateProduct(ProductUpdateDTO updateProduct);

}
