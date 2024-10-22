package com.finalProject.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.CouponDTO;
import com.finalProject.model.PagingInfo;

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
	public List<CouponDTO> selectCouponList(PagingInfo pi) throws Exception {
		return ses.selectList(ns + "selectAllCoupon", pi);
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

	

}
