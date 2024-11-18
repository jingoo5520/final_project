package com.finalProject.service.product;

import java.util.List;

import com.finalProject.model.product.PagingInfo;
import com.finalProject.model.product.ProductDTO;
import com.finalProject.model.review.ProductDetailReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;

public interface UserProductService {

    // 제품 목록
    List<ProductDTO> getProductsByPage(int page, int pageSize) throws Exception;
    
    // 제품의 총 개수
    int getProductCount() throws Exception;

    // 카테고리별 제품 목록
    List<ProductDTO> getProductsByCategoryAndPage(Integer category, int page, int pageSize, String sortOrder) throws Exception;

    // 카테고리별 제품 수 조회
    int getProductCountByCategory(Integer category) throws Exception;

    List<ProductDTO> getProductInfo(int productId) throws Exception;

    // content 상세 정보 메서드
    ProductDTO getProductDetailById(int productId) throws Exception;

    // 검색 게시물 수 조회
    int countSearchResults(String search, Integer category) throws Exception;

    // 검색 결과 조회
    List<ProductDTO> searchProducts(String search, Integer category, PagingInfo pagingInfo, String sortOrder) throws Exception;

    // 상품 리뷰 조회
	List<ProductDetailReviewDTO> getReviewDetail(int productNo, int offset, int limit) throws Exception;

    // 상품 리뷰 이미지 출력
//    List<String> getReviewImgs(int productNo) throws Exception;

    // 상품에 대한 리뷰 개수
	int countReview(int productNo) throws Exception;


}
