package com.finalProject.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.CouponDTO;
import com.finalProject.model.PagingInfo;
import com.finalProject.model.PagingInfoDTO;
import com.finalProject.persistence.CouponDAO;

@Service
public class CouponServiceImpl implements CouponService {

	@Inject
	CouponDAO cDao;
	
	@Override
	public Map<String, Object> getCouponList(PagingInfoDTO pagingInfoDTO) throws Exception {
		
		PagingInfo pi = makePagingInfo(pagingInfoDTO);
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<CouponDTO> list = cDao.selectCouponList(pi);
		
		result.put("pi", pi);
		result.put("list", list);
				
		return result;
	}
	
	private PagingInfo makePagingInfo(PagingInfoDTO pagingInfoDTO) throws Exception {
		PagingInfo pi = new PagingInfo(pagingInfoDTO);
		
		// setter 호출
		pi.setTotalDataCnt(cDao.getTotalCouponCnt());
		
		pi.setTotalPageCnt();
		pi.setStartRowIndex();
		
		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();
		
		return pi;
	}

	@Override
	public int createCoupon(CouponDTO couponDTO) throws Exception {
		return cDao.insertCoupon(couponDTO);
	}

	@Override
	public int updateCoupon(CouponDTO couponDTO) throws Exception {
		return cDao.updateCoupon(couponDTO);
	}

	@Override
	public int deleteCoupon(int coupon_no) throws Exception {
		return cDao.deleteCoupon(coupon_no);
	}

}
