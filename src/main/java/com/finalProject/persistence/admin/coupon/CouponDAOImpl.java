package com.finalProject.persistence.admin.coupon;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.CouponPayDTO;
import com.finalProject.model.admin.coupon.PagingInfoNew;

@Repository
public class CouponDAOImpl implements CouponDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.couponMapper.";

	@Override
	public int getTotalCouponCnt() throws Exception {
		return ses.selectOne(ns + "selectCouponCnt");
	}
	
	@Override
	public List<CouponDTO> selectCouponList() throws Exception {
		return ses.selectList(ns + "selectAllCoupon");
	}
	
	@Override
	public List<CouponDTO> selectCouponList(PagingInfoNew pi) throws Exception {
		return ses.selectList(ns + "selectAllCouponWithPi", pi);
	}
	
	@Override
	public CouponDTO selectCoupon(int couponNo) throws Exception {
		return ses.selectOne(ns + "selectCoupon", couponNo);
	}
	
	@Override
	public int insertCoupon(CouponDTO couponDTO) throws Exception {
		return ses.insert(ns + "insertCoupon", couponDTO);
	}

	@Override
	public int updateCoupon(CouponDTO couponDTO) throws Exception {
		return ses.update(ns + "updateCoupon", couponDTO);
	}

	@Override
	public int deleteCoupon(int coupon_no) throws Exception {
		return ses.delete(ns + "deleteCoupon", coupon_no);
	}

	@Override
	public int insertCouponPayLogs(List<CouponPayDTO> list) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns + "insertCouponPayLogs", list);
	}

	@Override
	public List<CouponDTO> selectCouponPayLogList(PagingInfoNew pi) throws Exception {
		return ses.selectList(ns + "selectCouponPayLogList", pi);
	}

	@Override
	public int getCouponPayLogCnt() throws Exception {
		return ses.selectOne(ns + "selectCouponPayLogCnt");
	}

	

	

}
