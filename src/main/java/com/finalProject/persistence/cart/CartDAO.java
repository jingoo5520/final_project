package com.finalProject.persistence.cart;

import java.util.List;

import com.finalProject.model.cart.CartDTO;

public interface CartDAO {
	// 장바구니 번호 조회
	int selectCartNo(String memberId);

	// 장바구니 등록
	void insertCart(String memberId);

	// 장바구니 목록 조회
	List<CartDTO> selectCartItems(int cartNo);
	
}
