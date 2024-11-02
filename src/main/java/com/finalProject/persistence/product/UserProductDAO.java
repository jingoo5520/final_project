package com.finalProject.persistence.product;

import java.util.List;
import java.util.Map;

import com.finalProject.model.product.PagingInfo;
import com.finalProject.model.product.ProductDTO;

public interface UserProductDAO {
	
	// 상품 출력
	List<ProductDTO> selectProductsByPage(int offset, int pageSize) throws Exception;

	// 페이지네이션
	int selectProductCount() throws Exception;

	// 카테고리 번호에 따른 상품 개수 조회
	int selectProductCountByCategory(Map<String, Object> params) throws Exception;
	
	// 카테고리 번호와 페이지에 따른 상품 조회
	List<ProductDTO> selectProductsByCategoryAndPage(Map<String, Object> params) throws Exception;

	List<ProductDTO> getProductById (int productId) throws Exception;

	ProductDTO getProductDetailById(int productId) throws Exception;

	// 총 게시물 수 조회
	int countSearchResult(String search, Integer category) throws Exception;

	// 검색된 상품 조회
	List<ProductDTO> searchProducts(String search, Integer category, int startRowIndex, int pageSize, String sortOrder);
}