package com.finalProject.persistence.admin.notices;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.notices.BannerVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Mapper
@Repository
public class BannerDAOImpl implements BannerDAO {

	/*
	 * @Autowired private SqlSession ses;
	 * 
	 * private String ns = "com.finalProject.mappers.bannerMapper.";
	 * 
	 * @Override public void insertBanner(BannerVO banner) { ses.insert(ns +
	 * "insertBanner", banner); }
	 * 
	 * @Override public List<BannerVO> getBanners() { return ses.selectList(ns +
	 * "getBanners"); }
	 * 
	 * @Override public void updateSelectedBanner(String fileName) { ses.update(ns +
	 * "updateSelectedBanner", fileName); }
	 */
}
