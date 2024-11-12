package com.finalProject.service.admin.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.review.AdminReviewDTO;
import com.finalProject.model.admin.review.AdminReviewDetailDTO;
import com.finalProject.model.admin.review.ReviewImgDTO;
import com.finalProject.model.admin.review.ReviewReplyDTO;
import com.finalProject.model.admin.review.ReviewSearchFilterDTO;
import com.finalProject.persistence.admin.review.AdminReviewDAO;

@Service
public class AdminReviewServiceImpl implements AdminReviewService {

	@Inject
	AdminReviewDAO arDao;

	@Override
	public Map<String, Object> getReviewList(ReviewSearchFilterDTO dto) throws Exception {
		int pageNo = dto.getPageNo();
		int pagingSizeg = dto.getPagingSize();
		int pageCntPerBlock = dto.getPageCntPerBlock();
		
		PagingInfoNew pi = new PagingInfoNew(new PagingInfoNewDTO(pageNo, pagingSizeg, pageCntPerBlock));

		// setter 호출
		pi.setTotalDataCnt(arDao.selectTotalReviewCnt(dto));

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminReviewDTO> list = arDao.selectReviewList(dto, pi);

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
			arDao.updateReviewHasReply(dto.getReview_ref());
			result = arDao.insertReviewReply(dto);
		} else {
			result = arDao.updateReviewReply(dto);
		}
		
		
		
		return result;
	}

	@Override
	public int deleteReview(int reviewNo, String reason) throws Exception {
		return arDao.deleteReview(reviewNo, reason);
	}

}
