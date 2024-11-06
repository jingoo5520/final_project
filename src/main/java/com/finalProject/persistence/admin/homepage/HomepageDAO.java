package com.finalProject.persistence.admin.homepage;

import java.util.List;

import com.finalProject.model.admin.homepage.BannerDTO;
import com.finalProject.model.admin.homepage.EventDTO;

public interface HomepageDAO {

	// 이벤트 리스트 가져오기
	List<EventDTO> selectEventList() throws Exception;

	// 이벤트 정보 가져오기
	EventDTO selectEvent(int eventNo) throws Exception;

	// 배너 추가
	int insertBanner(String bannerType, int eventNo) throws Exception;

	// 배너 리스트 가져오기
	List<BannerDTO> selectBannerList() throws Exception;

	// 배너 삭제
	int deleteBanner(int bannerNo) throws Exception;

}
