package com.finalProject.service.admin.homepage;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.homepage.BannerDTO;
import com.finalProject.model.admin.homepage.EventDTO;
import com.finalProject.persistence.admin.homepage.HomepageDAO;

@Service
public class HomepageServiceImpl implements HomepageService{

	@Inject
	HomepageDAO hDao;
	
	
	@Override
	public List<EventDTO> getEventList() throws Exception {
		
		return hDao.selectEventList();
	}


	@Override
	@Transactional
	public int addBanner(int eventNo, String bannerType) throws Exception {

		EventDTO event = hDao.selectEvent(eventNo);
		
		String uri = bannerType.equals('M') ? event.getBanner_image() : event.getThumbnail_image();
		
		return hDao.insertBanner(bannerType, eventNo); 
	}


	@Override
	public List<BannerDTO> getBannerList() throws Exception {
		return hDao.selectBannerList();
	}


	@Override
	public int deleteBanner(int bannerNo) throws Exception {
		return hDao.deleteBanner(bannerNo);
	}

}
