package com.finalProject.persistence;

import java.util.List;
import java.util.Map;

import com.finalProject.model.ProductDTO;
import com.finalProject.model.ProductUpdateDTO;
import com.finalProject.model.ProductVO;

public interface ProductDAO {

	int saveProduct(ProductDTO productDTO);

	int insertMainImage(String mainImage, int productId);

	int insertSubImage(List<String> subImages, int productId);

	List<ProductDTO> getAllProducts(Map<String, Object> map);

	int updateProduct(ProductUpdateDTO updateProduct);

	List<ProductVO> getSearchProducts(Map<String, Object> map);

	List<ProductDTO> getFilterProducts();

	int getTotalPostCnt();

	int getTotalSearchCnt(Map<String, Object> map);

	int updateProductImg(ProductUpdateDTO updateProduct);

	int deleteProduct(int productId);

}
