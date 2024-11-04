package com.finalProject.service.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalProject.model.review.ReviewPagingInfo;
import com.finalProject.model.review.ReviewDTO;
import com.finalProject.persistence.review.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDAO RDao;

	// 작성 가능 리뷰 개수
	@Override
	public int countWritableReviews(String member_id) throws Exception {
		return RDao.selectCountWritableReviews(member_id);
	}

	// 작성 가능 리뷰 조회
	@Override
	public List<ReviewDTO> getWritableReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception {
		return RDao.selectWritableReviews(member_id, pagingInfo);
	}
	
}
