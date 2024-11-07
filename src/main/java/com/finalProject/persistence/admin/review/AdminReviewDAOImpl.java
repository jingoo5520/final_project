package com.finalProject.persistence.admin.review;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.PagingInfoNew;

@Repository
public class AdminReviewDAOImpl implements AdminReviewDao {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.adminReviewMapper.";
	
	@Override
	public int selectTotalReviewCnt() throws Exception {
		return ses.selectOne(ns + "selectTotalReviewCnt");
	}

	@Override
	public List<CouponDTO> selectReviewList(PagingInfoNew pi) throws Exception {
		return ses.selectList(ns + "selectReviewList", pi);
	}

}
