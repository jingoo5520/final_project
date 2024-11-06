package com.finalProject.persistence.admin.homepage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.homepage.BannerDTO;
import com.finalProject.model.admin.homepage.EventDTO;

@Repository
public class HomepageDAOImpl implements HomepageDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.homepageMapper.";
	
	@Override
	public List<EventDTO> selectEventList() throws Exception {
		return ses.selectList(ns + "selectEventList");
	}

	@Override
	public EventDTO selectEvent(int eventNo) throws Exception {
		return ses.selectOne(ns + "selectEvent", eventNo);
	}

	@Override
	public int insertBanner(String bannerType, int eventNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bannerType", bannerType);
		map.put("eventNo", eventNo);
		
		return ses.insert(ns + "insertBanner", map);
	}

	@Override
	public List<BannerDTO> selectBannerList() throws Exception {
		return ses.selectList(ns + "selectBannerList");
	}

	@Override
	public int deleteBanner(int bannerNo) throws Exception {
		
		return ses.delete(ns + "deleteBanner", bannerNo);
	}

}
