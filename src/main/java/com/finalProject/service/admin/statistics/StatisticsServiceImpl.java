package com.finalProject.service.admin.statistics;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalProject.persistence.admin.statistics.StatisticsDAO;
import com.finalProject.service.admin.notices.NoticeServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StatisticsServiceImpl implements StatisticsService {

	@Autowired
	private StatisticsDAO sDao;
	
	@Override
	public int getTotalSalesLastMonth() throws Exception {
		return sDao.getTotalSalesLastMonth();
	}

	@Override
	public int getTodayOrderCount() throws Exception {
		return sDao.getTodayOrderCount();
	}

	@Override
	public int getTotalOrdersThisMonth() throws Exception {
		return sDao.getTotalOrdersThisMonth();
	}

	@Override
	public double getCancelOrdersThisMonth() throws Exception {
		return sDao.getCancelOrdersThisMonth();
	}

	@Override
	public double getReturnOrdersThisMonth() throws Exception {
		return sDao.getReturnOrdersThisMonth();
	}

	@Override
	public List<Map<String, Object>> getSalesByCategory() throws Exception {
		return sDao.getSalesByCategory();
	}

	@Override
	public List<Map<String, Object>> getSalesByPriceRange() throws Exception {
		return sDao.getSalesByPriceRange();
	}

	@Override
	public List<Map<String, Object>> getSalesByAgeGroup() throws Exception {
	    return sDao.getSalesByAgeGroup(); // DAO에서 데이터 가져오기
	}


}
