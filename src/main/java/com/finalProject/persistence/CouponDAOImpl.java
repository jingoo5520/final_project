package com.finalProject.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.CouponDTO;

@Repository
public class CouponDAOImpl implements CouponDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.couponMapper.";

	@Override
	public List<CouponDTO> selectCouponList() throws Exception {
		return ses.selectList(ns + "selectAllCoupon");
	}
	
	@Override
	public int insertCoupon(CouponDTO couponDTO) throws Exception {
		System.out.println("dao: insertCoupon");
		return ses.insert(ns + "insertCoupon", couponDTO);
	}

}
