package com.finalProject.service.cart;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.cart.CartDTO;
import com.finalProject.persistence.cart.CartDAO;

@Service
public class CartServiceImpl implements CartService {
	
	@Inject
	CartDAO cDAO;
	
	
	@Override
	public List<CartDTO> getCartList(String memberId) {
		
		CartDTO cDTO = null;
		int cartNo = cDAO.selectCartNo(memberId);
		
		List<CartDTO> cartItems = null;
		if (cartNo == 0) {
			// 해당 회원의 장바구니 목록이 없다면
			cDAO.insertCart(memberId);
			
		} else {
			// 해당 회원의 장바구니 목록이 있다면
			cartItems = cDAO.selectCartItems(cartNo);
			
			for (CartDTO item : cartItems) {
				System.out.println(item.toString());
			}
			
			
		}
		
		return cartItems;
		
		
	}

}
