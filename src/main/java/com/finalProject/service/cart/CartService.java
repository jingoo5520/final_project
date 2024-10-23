package com.finalProject.service.cart;

import java.util.List;

import com.finalProject.model.cart.CartDTO;

public interface CartService {

	List<CartDTO> getCartList(String memberId);
	
}
