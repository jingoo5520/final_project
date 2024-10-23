package com.finalProject.persistence.cart;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.cart.CartDTO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	SqlSession ses;
	
	private String ns = "com.finalProject.mappers.cartMapper.";
	
	// 장바구니 생성
	@Override
	public void insertCart(String memberId) {
		ses.insert(ns + "insertCart", memberId);
	}

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
	
	// 장바구니 목록 조회
	@Override
	public List<CartDTO> selectCartItems(int cartNo) {
		
		return ses.selectList(ns + "selectCartItems", cartNo);
	}

}
