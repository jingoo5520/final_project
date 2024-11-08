package com.finalProject.persistence.admin.review;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.review.AdminReviewDetailDTO;
import com.finalProject.model.admin.review.ReviewImgDTO;
import com.finalProject.model.admin.review.ReviewReplyDTO;

@Repository
public class AdminReviewDAOImpl implements AdminReviewDAO {

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

	@Override
	public AdminReviewDetailDTO selectReview(int reviewNo) throws Exception {
		return ses.selectOne(ns + "selectReview", reviewNo);
	}

	@Override
	public List<ReviewImgDTO> selectReviewImages(int reviewNo) throws Exception {
		return ses.selectList(ns + "selectReviewImages", reviewNo);
	}

	@Override
	public ReviewReplyDTO selectReviewReply(int reviewNo) throws Exception {
		return ses.selectOne(ns + "selectReviewReply", reviewNo);
	}

	@Override
	public int insertReviewReply(ReviewReplyDTO dto) throws Exception {
		return ses.insert(ns + "insertReviewReply", dto);
	}

	@Override
	public int updateReviewReply(ReviewReplyDTO dto) throws Exception {
		return ses.update(ns + "updateReviewReply", dto);
	}
	
	

}
