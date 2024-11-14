package com.finalProject.service.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.cart.CartDTO;
import com.finalProject.model.cart.CartMemberLevelDTO;
import com.finalProject.model.cart.CookieCartDTO;
import com.finalProject.persistence.cart.CartDAO;

@Service
public class CartServiceImpl implements CartService {
	
	@Inject
	CartDAO cDAO;
	
	@Override
	public int getCartNo(String memberId) {
		return cDAO.selectCartNo(memberId);
	}
	
	@Override
	public void addCartList(String member_id) {
		cDAO.insertCartList(member_id);
	}
	
	@Override
	public List<CartDTO> getCartList(int cartNo) {
				
		List<CartDTO> cartItems = cDAO.selectCartItems(cartNo);
		
		return cartItems;
	}

	@Override
	public int applyQuantity(Map<String, Object> cMap) {
		return cDAO.updateQuantity(cMap);
	}

	@Override
	public int removeCartItem(Map<String, Object> cMap) {
		return cDAO.deleteCartItem(cMap);
	}

	@Override
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
	public void addCartIteminNewList(String memberId, int productNo, int quantity) {
		
		// 장바구니 생성
		cDAO.insertCartList(memberId);
		
		// 생성된 장바구니 번호 조회
		int cartNo = cDAO.selectCartNo(memberId);
		
		Map<String, Object> cMap = mappingData(cartNo, productNo, quantity);
		
		// 생성된 장바구니에 상품 등록
		cDAO.insertCartItem(cMap);
		
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
	public void addCartItem(int cartNo, int productNo, int quantity, String memberId) {
		
		Map<String, Object> cMap = mappingData(cartNo, productNo, quantity);
		
		if (cDAO.findCartItemByProductNo(cMap) != 0) {
			// 장바구니 상품 목록에 해당 상품이 있는 경우 > 수량 수정 / 기존 수량 + quantity
			cDAO.updateQuantityFromAddItem(cMap);
			
		} else {
			// 장바구니 상품 목록에 해당 상품이 없는 경우
			cDAO.insertCartItem(cMap);
		}
		
	}
	
	private Map<String, Object> mappingData(int cartNo, int productNo, int quantity) {
		
		Map<String, Object> cMap = new HashMap<>();
		cMap.put("cartNo", cartNo);
		cMap.put("productNo", productNo);
		cMap.put("quantity", quantity);
		
		return cMap;
	}

	@Override
	public int getCartItemCount(int cartNo) {
		
		return cDAO.selectCntCartItem(cartNo);
	}

	@Override
	public CartMemberLevelDTO getLevelInfo(String memberId) {
		return cDAO.selectLevelInfoOfMemberId(memberId);
	}

	@Override
	public CookieCartDTO getProductInfoOfCookieCart(int productNo) {
		CookieCartDTO cookieCartDTO = cDAO.selectProductInfoByCookie(productNo);
		
		System.out.println(cookieCartDTO);
		
		if (cookieCartDTO == null) {
			System.out.println("없음 이미지");
		}
		
		return cookieCartDTO;
	}

	@Override
	public void mergeQuantityExistCookie(Map<String, Object> cMap) {
		cDAO.updateQuantityWithCookieCart(cMap);
	}

	@Override
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
	public boolean removeCartList(List<Integer> productNoList, String memberId) {
		Map<String, Object> cMap = new HashMap<>();
		
		boolean result = false;
		
		for (int productNo : productNoList) {
			cMap.put("productNo", productNo);
			cMap.put("memberId", memberId);
			
			if (cDAO.deleteCartItem(cMap) != 0) {
				result = true;
			} else {
				result = false;
			}
		}
		return result;
	}

	@Override
	public List<Integer> getProductNo(int cartNo) {
		return cDAO.selectProductNoOfCartList(cartNo);
	}

}
