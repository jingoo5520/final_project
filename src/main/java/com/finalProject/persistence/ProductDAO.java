package com.finalProject.persistence;

import java.util.List;

import com.finalProject.model.ProductDTO;
import com.finalProject.model.ProductUpdateDTO;

public interface ProductDAO {

	int saveProduct(ProductDTO productDTO);

	int insertMainImage(String mainImage, int productId);

	int insertSubImage(List<String> subImages, int productId);

	List<ProductDTO> getAllProducts();

	int updateProduct(ProductUpdateDTO updateProduct);

}
