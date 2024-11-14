package com.finalProject.persistence.admin.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.review.AdminReviewDTO;
import com.finalProject.model.admin.review.AdminReviewDetailDTO;
import com.finalProject.model.admin.review.ReviewImgDTO;
import com.finalProject.model.admin.review.ReviewReplyDTO;
import com.finalProject.model.admin.review.ReviewSearchFilterDTO;

@Repository
public class AdminReviewDAOImpl implements AdminReviewDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.adminReviewMapper.";
	
	@Override
	public int selectTotalReviewCnt(ReviewSearchFilterDTO dto) throws Exception {
		return ses.selectOne(ns + "selectTotalReviewCnt", dto);
	}

	@Override
	public List<AdminReviewDTO> selectReviewList(ReviewSearchFilterDTO dto, PagingInfoNew pi) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("dto", dto);
		params.put("pi", pi);
		
		return ses.selectList(ns + "selectReviewList", params);
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

	@Override
	public int deleteReview(int reviewNo, String reason) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("reviewNo", reviewNo);
		params.put("reason", reason);
		
		// 리뷰 삭제 = 상태 변경
		return ses.delete(ns + "updateReview", params);
	}

	@Override
	public int updateReviewHasReply(int review_ref) throws Exception {
		return ses.update(ns + "updateReviewHasReply", review_ref);
	}
	
	

}
