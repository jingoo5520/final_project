package com.finalProject.persistence.cart;

import java.util.List;
import java.util.Map;

import com.finalProject.model.cart.CartDTO;
import com.finalProject.model.cart.CartMemberLevelDTO;
import com.finalProject.model.cart.CookieCartDTO;

public interface CartDAO {
	// 장바구니 번호 조회
	int selectCartNo(String memberId);

	// 장바구니 등록
	void insertCartList(String memberId);

	// 장바구니 목록 조회
	List<CartDTO> selectCartItems(int cartNo);
	
	// 장바구니 상품 수량 수정
	int updateQuantity(Map<String, Object> cMap);
	
	// 장바구니 상품 삭제
	int deleteCartItem(Map<String, Object> cMap);
	
	// 장바구니 상품 등록
	int insertCartItem(Map<String, Object> cMap);
	
	// 장바구니 목록에서 해당 상품 조회
	int findCartItemByProductNo(Map<String, Object> cMap);
	
	// 장바구니 상품 등록 시 기존에 있던 상품 수량 수정
	int updateQuantityFromAddItem(Map<String, Object> cMap);
	
	// 장바구니 상품 개수 조회
	int selectCntCartItem(int cartNo);
	
	// 장바구니를 조회한 회원의 등급 정보 조회
	CartMemberLevelDTO selectLevelInfoOfMemberId(String memberId);
	
	// 쿠키로 저장된 상품정보 조회
	CookieCartDTO selectProductInfoByCookie(int productNo);
	
	// 장바구니의 쿠키와 중복 상품 수량 수정
	void updateQuantityWithCookieCart(Map<String, Object> cMap);
	
	// 장바구니의 담긴 상품의 상품 번호를 조회
	List<Integer> selectProductNoOfCartList(int cartNo);
	
}
