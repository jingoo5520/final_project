package com.finalProject.persistence.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.review.ReviewPagingInfo;
import com.finalProject.model.review.ReviewDTO;

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
	    
	    System.out.println("DAO에 전달된 파라미터: " + param);
		
		return ses.selectList(ns + "selectWritableReviews", param);
	}

}
