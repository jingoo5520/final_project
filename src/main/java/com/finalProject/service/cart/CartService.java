package com.finalProject.service.cart;

import java.util.List;
import java.util.Map;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.cart.CartDTO;
import com.finalProject.model.cart.CartMemberLevelDTO;
import com.finalProject.model.cart.CookieCartDTO;

public interface CartService {

	int getCartNo(String memberId);
	
	void addCartList(String member_id);
	
	List<CartDTO> getCartList(int cartNo);

	int applyQuantity(Map<String, Object> cMap);

	int removeCartItem(Map<String, Object> cMap);

	void addCartIteminNewList(String memberId, int productNo, int quantity);

	void addCartItem(int cartNo, int productNo, int quantity, String memberId);

	int getCartItemCount(int cartNo);

	CartMemberLevelDTO getLevelInfo(String memberId);

	CookieCartDTO getProductInfoOfCookieCart(int productNo);

	void mergeQuantityExistCookie(Map<String, Object> cMap);

	boolean removeCartList(List<Integer> productNoList, String member_id);

	List<Integer> getProductNo(int cartNo);



}
