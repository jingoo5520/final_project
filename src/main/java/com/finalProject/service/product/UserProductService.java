package com.finalProject.service.product;

import java.util.List;

import com.finalProject.model.product.PagingInfo;
import com.finalProject.model.product.ProductDTO;

public interface UserProductService {

	// ��ǰ ���
	List<ProductDTO> getProductsByPage(int page, int pageSize) throws Exception;
	
	// ��ǰ�� ��������
	int getProductCount() throws Exception;

	// ī�װ����� ��ǰ ���
	List<ProductDTO> getProductsByCategoryAndPage(Integer category, int page, int pageSize, String sortOrder) throws Exception;

	// ī�װ����� ��ǰ �� �˻�
	int getProductCountByCategory(Integer category) throws Exception;

	List<ProductDTO> getProductInfo(int productId) throws Exception;

	// content 가져오는 메소드
	ProductDTO getProductDetailById(int productId)throws Exception;

	// 총 게시물 수 조회
	int countSearchResults(String search, Integer category) throws Exception;

	// 검색 결과 조회
	List<ProductDTO> searchProducts(String search, Integer category, PagingInfo pagingInfo, String sortOrder) throws Exception;
	
}
