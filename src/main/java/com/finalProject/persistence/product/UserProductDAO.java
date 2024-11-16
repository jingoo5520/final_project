package com.finalProject.persistence.product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.finalProject.model.product.ProductDTO;
import com.finalProject.model.review.ProductDetailReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;

public interface UserProductDAO {
    
	// 제품 목록
	List<ProductDTO> selectProductsByPage(int offset, int pageSize) throws Exception;

	// 전체 제품 수 조회
	int selectProductCount() throws Exception;

	// 카테고리별 제품 수 조회
	int selectProductCountByCategory(Map<String, Object> params) throws Exception;

	// 카테고리별 페이지별 제품 조회
	List<ProductDTO> selectProductsByCategoryAndPage(Map<String, Object> params) throws Exception;

	// 제품 ID로 제품 조회
	List<ProductDTO> getProductById(int productId) throws Exception;

	// 제품 상세 정보 조회
	ProductDTO getProductDetailById(int productId) throws Exception;

	// 검색어와 카테고리에 맞는 게시물 수 조회
	int countSearchResult(String search, Integer category) throws Exception;

	// 검색된 제품 목록 조회
	List<ProductDTO> searchProducts(String search, Integer category, int startRowIndex, int pageSize, String sortOrder) throws Exception;

	// 리뷰 조회
	List<ProductDetailReviewDTO> selectReview(@Param("product_no") int productNo, int offset, int limit) throws Exception;

	// 리뷰 이미지 조회
//	List<String> selectReviewImg(@Param("product_no") int productNo) throws Exception;

	// 상품에 대한 리뷰 개수
	int selectCountReviewProduct(int productNo) throws Exception;
}
