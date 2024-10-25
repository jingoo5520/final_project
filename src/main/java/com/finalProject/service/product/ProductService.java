package com.finalProject.service.product;

import java.util.List;

import com.finalProject.model.ProductDTO;

public interface ProductService {

	// 상품 출력
	List<ProductDTO> getProductsByPage(int page, int pageSize) throws Exception;
	
	// 상품개수가져오기
	int getProductCount() throws Exception;

	// 카테고리별 상품 출력
	List<ProductDTO> getProductsByCategoryAndPage(Integer category, int page, int pageSize, String sortOrder)throws Exception;

	// 카테고리별 상품 수 계산
	int getProductCountByCategory(Integer category)throws Exception;

	
	List<ProductDTO> getProductInfo(int productId) throws Exception;

	// content 가져오는 메서드
	ProductDTO getProductDetailById(int productId)throws Exception;
	
}