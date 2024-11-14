package com.finalProject.persistence.cart;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.cart.CartDTO;
import com.finalProject.model.cart.CartMemberLevelDTO;
import com.finalProject.model.cart.CookieCartDTO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	SqlSession ses;
	
	private String ns = "com.finalProject.mappers.cartMapper.";
	
	// 장바구니 번호 조회
	@Override
	public int selectCartNo(String memberId) {
		Integer cartNo = ses.selectOne(ns + "selectCartNoByMemberId" ,memberId);
			
		if (cartNo == null) {
			// 장바구니가 없는 경우
			return 0;
		} else {
			return cartNo;
		}
	}
	
	// 장바구니 생성
	@Override
	public void insertCartList(String memberId) {
		ses.insert(ns + "insertCart", memberId);
	}

	// 장바구니 목록 조회
	@Override
	public List<CartDTO> selectCartItems(int cartNo) {
		
		return ses.selectList(ns + "selectCartItems", cartNo);
	}

	// 장바구니 상품 수량 수정
	@Override
	public int updateQuantity(Map<String, Object> cMap) {
		return ses.update(ns + "updateQuantity", cMap);
	}
	
	// 장바구니 상품 삭제
	@Override
	public int deleteCartItem(Map<String, Object> cMap) {
		return ses.delete(ns + "deleteCartItem", cMap);
	}
	
	// 장바구니 상품 등록
	@Override
	public int insertCartItem(Map<String, Object> cMap) {
		ses.insert(ns + "insertCartItem", cMap);
		return 0;
	}
	
	// 장바구니 목록에서 해당 상품 조회
	@Override
	public int findCartItemByProductNo(Map<String, Object> cMap) {
		Integer result = ses.selectOne(ns + "selectCountItemByProductNo", cMap);
		if (result == null) {
			return 0;
		} else {
			return result;
		}
	}
	
	// 장바구니 상품 등록 시 기존에 있던 상품 수량 수정
	@Override
	public int updateQuantityFromAddItem(Map<String, Object> cMap) {
		return ses.update(ns + "updateQuantityFromAddItem", cMap);
	}
	
	// 장바구니 상품 개수 조회
	@Override
	public int selectCntCartItem(int cartNo) {
		return ses.selectOne(ns + "selectCntCartItem", cartNo);
	}
	
	// 장바구니를 조회한 회원의 등급 정보 조회
	@Override
	public CartMemberLevelDTO selectLevelInfoOfMemberId(String memberId) {
		return ses.selectOne(ns + "selectLevelInfoOfMemberId", memberId);
	}
	
	// 쿠키로 저장된 상품정보 조회
	@Override
	public CookieCartDTO selectProductInfoByCookie(int productNo) {
		return ses.selectOne(ns + "selectProductInfoByCookie", productNo);
	}
	
	// 장바구니의 쿠키와 중복 상품 수량 수정
	@Override
	public void updateQuantityWithCookieCart(Map<String, Object> cMap) {
		ses.update(ns + "updateQuantityWithCookieCart", cMap);
	}

	// 장바구니의 담긴 상품의 상품 번호를 조회
	@Override
	public List<Integer> selectProductNoOfCartList(int cartNo) {
		return ses.selectList(ns + "selectProductNoOfCartList", cartNo);
	}

}
