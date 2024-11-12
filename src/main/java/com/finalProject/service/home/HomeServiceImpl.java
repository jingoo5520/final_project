package com.finalProject.service.home;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.homepage.BannerDTO;
import com.finalProject.model.home.HomeProductDTO;
import com.finalProject.persistence.admin.homepage.HomepageDAO;
import com.finalProject.persistence.home.HomeDAO;

@Service
public class HomeServiceImpl implements HomeService {

	@Inject
	HomeDAO hDao;
	
	@Override
	public Map<String, Object> getHomeData() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		// 추천아이템(신상품) 가져오기
		List<HomeProductDTO> newProducts = hDao.selectNewProducts(8);
		List<BannerDTO> bannerList = hDao.selectBannerList(); 
		
		result.put("newProducts", newProducts);
		result.put("bannerList", bannerList);
		return result;
	}

}
