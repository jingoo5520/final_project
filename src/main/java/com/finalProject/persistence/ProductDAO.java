package com.finalProject.persistence;

import java.util.List;

import com.finalProject.model.ProductDTO;

public interface ProductDAO {

	int saveProduct(ProductDTO productDTO);

	int insertMainImage(String mainImage, int productId);

	int insertSubImage(List<String> subImages, int productId);

	List<ProductDTO> getAllProducts();

}
