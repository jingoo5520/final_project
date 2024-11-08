package com.finalProject.service.review;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.review.ReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;
import com.finalProject.model.review.ReviewPagingInfo;
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
//		System.out.println("S서비스에서 전달받은 member_id: " + member_id);
//		System.out.println("S서비스에서 전달받은 PagingInfo: " + pagingInfo);

		List<ReviewDTO> result = RDao.selectWritableReviews(member_id, pagingInfo);
//		System.out.println("DAO에서 반환된 결과: " + result);
		
		return result;
	}

	// 작성한 리뷰 개수
	@Override
	public int countWrittenReviews(String member_id) throws Exception {
		return RDao.selectCountWrittenReviews(member_id);
	}

	// 작성 한 리뷰 조회
	@Override
	public List<ReviewDTO> getWrittenReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception {
		return RDao.selectWrittenReviews(member_id, pagingInfo);
	}

	// 리뷰 생성 저장
	@Override
	@Transactional
	public void saveReview(ReviewDTO reviewDTO, HttpServletRequest request) throws Exception {
		
	    // 리뷰 데이터 저장
	    RDao.insertReview(reviewDTO);

	    // 서버 실제 파일 저장 경로 설정
	    String url = "/resources/reviewImg"; // 서버 경로
	    
	    String realPath = request.getSession().getServletContext().getRealPath(url);
	    
	    	
	    // 생성된 리뷰 번호 가져오기 (MyBatis의 selectKey 활용 가능)
	    int reviewNo = reviewDTO.getReview_no();

	    // 파일 존재 여부
	    if (reviewDTO.getFiles() != null && reviewDTO.getFiles().length > 0) {
	        
	        // 각 파일을 저장하고 review_images 테이블에 저장
	        List<ReviewDTO> imageList = new ArrayList<>();
	        
	        // 파일 반복 배열 처리
	        for (MultipartFile file : reviewDTO.getFiles()) {
	        	
	        	// 파일 비어있는지 확인
	            if (!file.isEmpty()) {
	            	
	                try {
						// 고유 파일명 생성
						String fileName = "Review"+UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
						String filePath = realPath + File.separator + fileName;

						// 파일 서버에 저장 (파일 경로 + 이름)
						File destinationFile = new File(filePath);
						file.transferTo(destinationFile);

						
						// 이미지 정보 DTO에 저장
						ReviewDTO reviewImageDTO = new ReviewDTO();
						reviewImageDTO.setReview_no(reviewNo);
						
	                    // 파일 경로에서 /resources/reviewImg 이후의 부분만 추출
	                    String relativePath = filePath.split("resources")[1];
	                    relativePath = "/resources" + relativePath.replace("\\", "/"); // 경로 수정

	                    // db 상대 경로 저장
	                    reviewImageDTO.setImage_url(relativePath); // DB에 상대 경로 저장
	                    imageList.add(reviewImageDTO);
						
						
					} catch (IOException e) {
						throw new RuntimeException("파일 저장 중 오류 발생" , e);
					}
	            }
	        }
	        // 리뷰 이미지 정보 저장
	        if (!imageList.isEmpty()) {
	            RDao.insertReviewImages(imageList);
	        }
	    }
	}
	
	
	// 이미지 가져오기
	@Override
	public String getImageUrl(int product_no) {
		return RDao.getImage(product_no);
	}

	// 리뷰 상세 조회
	@Override
	public List<ReviewDetailDTO> getReviewDetail(int review_no) throws Exception {
		
		return RDao.selectReviewDetail(review_no);
		
	}

	// 리뷰 이미지 
	@Override
	public List<String> getReviewImages(int reviewNo) throws Exception {
		return RDao.selectReviewImage(reviewNo);
	}
	
}
