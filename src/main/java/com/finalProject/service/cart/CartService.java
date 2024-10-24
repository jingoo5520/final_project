package com.finalProject.service.cart;

import java.util.List;
import java.util.Map;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.cart.CartDTO;

public interface CartService {

	int getCartNo(String memberId);
	
	void addCartList(String member_id);
	
	List<CartDTO> getCartList(int cartNo);

	int applyQuantity(Map<String, Object> cMap);

	int removeCartItem(Map<String, Object> cMap);

	void addCartIteminNewList(String memberId, int productNo, int quantity);

	void addCartItem(int cartNo, int productNo, int quantity, String memberId);



}
