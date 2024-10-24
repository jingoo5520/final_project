package com.finalProject.persistence.cart;

import java.util.List;
import java.util.Map;

import com.finalProject.model.cart.CartDTO;

public interface CartDAO {
	// 장바구니 번호 조회
	int selectCartNo(String memberId);

	// 장바구니 등록
	void insertCartList(String memberId);

	// 장바구니 목록 조회
	List<CartDTO> selectCartItems(int cartNo);
	
	// 장바구니 상품 수량 설정
	int updateQuantity(Map<String, Object> cMap);
	
	// 장바구니 상품 삭제
	int deleteCartItem(Map<String, Object> cMap);
	
	// 장바구니 상품 등록
	int insertCartItem(Map<String, Object> cMap);
	
	// 장바구니 목록에서 해당 상품 조회
	int findCartItemByProductNo(Map<String, Object> cMap);
	
	// 장바구니 상품 등록 시 기존에 있던 상품 수량 수정
	int updateQuantityFromAddItem(Map<String, Object> cMap);
	
}
