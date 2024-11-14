package com.finalProject.service.admin.statistics;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalProject.model.admin.statistics.AgeGroupSalesDTO;
import com.finalProject.model.admin.statistics.CateSalesDTO;
import com.finalProject.model.admin.statistics.GenderSalesDTO;
import com.finalProject.model.admin.statistics.PriceRangeDTO;
import com.finalProject.persistence.admin.statistics.StatisticsDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StatisticsServiceImpl implements StatisticsService {

	@Autowired
	private StatisticsDAO sDao;
	
	@Override
	public int getTotalSalesThisMonth() throws Exception {
		return sDao.getTotalSalesThisMonth();
	}
	
	@Override
	public int getTotalSalesLastMonth() throws Exception {
		return sDao.getTotalSalesLastMonth();
	}
	
	@Override
	public int getTotalSalesLastYear() throws Exception {
		return sDao.getTotalSalesLastYear();
	}
	
	@Override
	public int getTotalSalesFirstHalfYear() throws Exception {
		return sDao.getTotalSalesFirstHalfYear();
	}
	
	@Override
	public int getTotalSalesSecondHalfYear() throws Exception {
		return sDao.getTotalSalesSecondHalfYear();
	}
	
	@Override
	public int getTotalSalesThisYear() throws Exception {
		return sDao.getTotalSalesThisYear();
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
	public List<CateSalesDTO> getSalesByCategory() throws Exception {
		return sDao.getSalesByCategory();
	}

	@Override
	public List<PriceRangeDTO> getSalesByPriceRange() throws Exception {
		return sDao.getSalesByPriceRange();
	}

	@Override
	public List<AgeGroupSalesDTO> getSalesByAgeGroup() throws Exception {
	    return sDao.getSalesByAgeGroup();
	}

	@Override
	public List<GenderSalesDTO> getSalesByGender() throws Exception {
		return sDao.getSalesByGender();
	}

//	@Override
//	public int getVisitorCount() throws Exception {
//		return sDao.getVisitorCount();
//	}



}
