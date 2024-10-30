package com.finalProject.service.product;

import java.util.List;

import com.finalProject.model.product.PagingInfo;
import com.finalProject.model.product.ProductDTO;

public interface ProductService {

	// 상품 출력
	List<ProductDTO> getProductsByPage(int page, int pageSize) throws Exception;
	
	// 상품수 가져오기
	int getProductCount() throws Exception;

	// 카테고리별 상품 출력
	List<ProductDTO> getProductsByCategoryAndPage(Integer category, int page, int pageSize, String sortOrder)throws Exception;

	// 카테고리별 상품 수 검색
	int getProductCountByCategory(Integer category)throws Exception;

	
	List<ProductDTO> getProductInfo(int productId) throws Exception;

	// content 가져오는 메소드
	ProductDTO getProductDetailById(int productId)throws Exception;

	// 총 게시물 수 조회
	int countSearchResults(String search, Integer category) throws Exception;

	// 검색 결과 조회
	List<ProductDTO> searchProducts(String search, Integer category, PagingInfo pagingInfo, String sortOrder) throws Exception;
	
}