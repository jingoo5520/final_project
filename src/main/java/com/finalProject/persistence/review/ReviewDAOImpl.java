package com.finalProject.persistence.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.review.ReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;
import com.finalProject.model.review.ReviewPagingInfo;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	SqlSession ses;
	
	private String ns = "com.finalProject.mappers.reviewMapper.";
	
	@Override
	public int selectCountWritableReviews(String member_id) throws Exception {
		return ses.selectOne(ns + "selectCountWritableReviews" , member_id);
	}

	@Override
	public List<ReviewDTO> selectWritableReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception {
	    Map<String, Object> param = new HashMap<>();
	    param.put("member_id", member_id);
	    param.put("pagingInfo", pagingInfo);
	    
//	    System.out.println("DAO에 전달된 파라미터: " + param);
		
		return ses.selectList(ns + "selectWritableReviews", param);
	}

	@Override
	public int selectCountWrittenReviews(String member_id) throws Exception {
		return ses.selectOne(ns + "selectCountWrittenReviews", member_id);
	}

	@Override
	public List<ReviewDTO> selectWrittenReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("member_id", member_id);
        param.put("pagingInfo", pagingInfo);
        
        return ses.selectList(ns + "selectWrittenReviews", param);
	}

    @Override
    public void insertReview(ReviewDTO reviewDTO) throws Exception {
        ses.insert(ns + "insertReview", reviewDTO);
    }

    @Override
    public void insertReviewImages(List<ReviewDTO> imageList) throws Exception {
        ses.insert(ns + "insertReviewImages", imageList);
    }

	// 이미지 가져오기
	@Override
	public String getImage(int product_no) {
		return ses.selectOne(ns + "findImageUrlByProductNo" , product_no);
	}

	// 리뷰 상세 정ㅈ보
	@Override
	public List<ReviewDetailDTO> selectReviewDetail(int review_no) throws Exception {
		
		return ses.selectList(ns + "selectReviewDetail" , review_no);
	}

	@Override
	public int saveReview(ReviewDTO reviewDTO) {
		
		return 0;
	}

}
