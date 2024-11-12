package com.finalProject.persistence.home;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.homepage.BannerDTO;
import com.finalProject.model.home.HomeProductDTO;

@Repository
public class HomeDAOImpl implements HomeDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.homeMapper.";
	
	@Override
	public List<HomeProductDTO> selectNewProducts(int count) {
		return ses.selectList(ns + "selectNewProducts", count);
	}

	@Override
	public List<BannerDTO> selectBannerList() throws Exception {
		return ses.selectList(ns + "selectBannerList");
	}
}
