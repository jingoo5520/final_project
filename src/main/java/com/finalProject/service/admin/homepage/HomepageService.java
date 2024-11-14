package com.finalProject.service.admin.homepage;

import java.util.List;

import com.finalProject.model.admin.homepage.BannerDTO;
import com.finalProject.model.admin.homepage.EventDTO;

public interface HomepageService {

	// 이벤트 리스트 가져오기
	List<EventDTO> getEventList() throws Exception;

	// 배너 추가하기
	int addBanner(int eventNo, String bannerType) throws Exception;

	// 배너 리스트 가져오기
	List<BannerDTO> getBannerList() throws Exception;

	// 배너 삭제
	int deleteBanner(int bannerNo) throws Exception;
	
}
