package com.finalProject.service.admin.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.review.AdminReviewDetailDTO;
import com.finalProject.model.admin.review.ReviewImgDTO;
import com.finalProject.model.admin.review.ReviewReplyDTO;
import com.finalProject.persistence.admin.review.AdminReviewDAO;

@Service
public class AdminReviewServiceImpl implements AdminReviewService {

	@Inject
	AdminReviewDAO arDao;

	@Override
	public Map<String, Object> getReviewList(PagingInfoNewDTO pagingInfoDTO) throws Exception {

		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);

		// setter 호출
		pi.setTotalDataCnt(arDao.selectTotalReviewCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<CouponDTO> list = arDao.selectReviewList(pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	@Override
	public Map<String, Object> getReview(int reviewNo) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		AdminReviewDetailDTO reviewDetailDTO = arDao.selectReview(reviewNo);
		List<ReviewImgDTO> reviewImages = arDao.selectReviewImages(reviewNo);
		ReviewReplyDTO ReviewReplyDTO = arDao.selectReviewReply(reviewNo);

		result.put("reviewDetail", reviewDetailDTO);
		result.put("reviewImages", reviewImages);
		result.put("reviewReply", ReviewReplyDTO);

		return result;
	}

	@Override
	public int writeReviewReply(ReviewReplyDTO dto) throws Exception {
		int result = 0;

		// 신규 작성
		if (dto.getReview_no() == 0) {
			result = arDao.insertReviewReply(dto);
		} else {
			result = arDao.updateReviewReply(dto);
		}
		return result;
	}

}
