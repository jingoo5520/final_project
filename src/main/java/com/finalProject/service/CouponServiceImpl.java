package com.finalProject.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.CouponDTO;
import com.finalProject.persistence.CouponDAO;

@Service
public class CouponServiceImpl implements CouponService {

	@Inject
	CouponDAO cDao;
	
	@Override
	public List<CouponDTO> getCouponList() throws Exception {
		
		
		return cDao.selectCouponList();
	}

	@Override
	public int createCoupon(CouponDTO couponDTO) throws Exception {
		return cDao.insertCoupon(couponDTO);
	}

}
