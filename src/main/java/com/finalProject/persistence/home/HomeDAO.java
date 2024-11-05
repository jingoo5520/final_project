package com.finalProject.persistence.home;

import java.util.List;

import com.finalProject.model.home.HomeProductDTO;

public interface HomeDAO {

	// 홈 - 신상품 가져오기
	List<HomeProductDTO> selectNewProducts(int count) throws Exception;

}
