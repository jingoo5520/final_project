package com.finalProject.service.review;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.review.PointEarnedDTO;
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
	public void saveReview(ReviewDTO reviewDTO, HttpServletRequest request, PointEarnedDTO pointDTO) throws Exception {
		
	    // 리뷰 데이터 저장
	    RDao.insertReview(reviewDTO);

	    // 포인트 적립 및 데이터 저장
	    pointDTO.setMember_id(reviewDTO.getMember_id());  // 로그인한 사용자 ID 설정
	    pointDTO.setPoint_code(4);  // 포인트 코드 설정 (예: 4는 리뷰 작성 포인트)
	    pointDTO.setEarned_point(500);  // 적립할 포인트 설정 (500 포인트)
	    RDao.pointMember(pointDTO);

	    
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

	// 관리자 답글 리뷰 수정 불가
	@Override
	public boolean hasAdminReply(int reviewNo) throws Exception {
		return RDao.checkAdminReply(reviewNo);
	}

	@Override
	@Transactional
	public void modifyReview(int reviewNo, String reviewTitle, String reviewContent, int reviewScore) throws Exception {
	    
	    // 리뷰 데이터 수정
	    ReviewDTO reviewDTO = new ReviewDTO();
	    reviewDTO.setReview_no(reviewNo);
	    reviewDTO.setReview_title(reviewTitle);
	    reviewDTO.setReview_content(reviewContent);
	    reviewDTO.setReview_score(reviewScore);

	    // 데이터베이스에서 리뷰 업데이트
	    RDao.updateReview(reviewDTO);
	}

	@Override
	public void modifyReviewImg(int reviewNo, MultipartFile[] files, List<String> existFiles, List<String> removedFiles,
			HttpServletRequest request) throws Exception {
		
	    String url = "/resources/reviewImg";
	    String realPath = request.getSession().getServletContext().getRealPath(url);

//	    System.out.println("files: " + files);
//	    System.out.println("existFiles: " + existFiles);
//	    System.out.println("removedFiles: " + removedFiles);
	    
	    // 1. 삭제할 파일 처리
	    if (removedFiles != null && !removedFiles.isEmpty()) {
	        for (String imageUrl : removedFiles) {
	            RDao.deleteReviewImage(imageUrl);

	            String fullPath = request.getSession().getServletContext().getRealPath(imageUrl);
	            File file = new File(fullPath);
	            if (file.exists()) {
	                file.delete();
	            }
	        }
	    }

	    // 2. 새 파일 저장 처리
	    if (files != null && files.length > 0) {
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                String fileName = "Review" + UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	                String filePath = realPath + File.separator + fileName;

	                File destinationFile = new File(filePath);
	                file.transferTo(destinationFile);

	                ReviewDTO reviewImageDTO = new ReviewDTO();
	                reviewImageDTO.setReview_no(reviewNo);

	                String relativePath = "/resources" + filePath.split("resources")[1].replace("\\", "/");
	                reviewImageDTO.setImage_url(relativePath);

	                RDao.modifyinsertReviewImage(reviewImageDTO);
	            }
	        }
	    }

	}

	@Override
	public List<String> getExistFileList(int reviewNo) throws Exception {
		return RDao.selectExistFileList(reviewNo);
	}

	@Override
	@Transactional
	public void deleteReview(int reviewNo, HttpServletRequest request) throws Exception {

	    // 1. 데이터베이스에서 해당 리뷰의 이미지 파일 경로 조회
	    List<String> imageUrls = RDao.getReviewImageUrlsByReviewNo(reviewNo);
	    
	    // 2. 서버 실제 파일 저장 경로 설정
	    String url = "/resources/reviewImg"; // 서버 경로
	    String realPath = request.getSession().getServletContext().getRealPath(url);

	    // 3. 이미지 파일 삭제
	    for (String imageUrl : imageUrls) {
	        // 서버에서 파일 삭제
	        String fullPath = realPath + File.separator + imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
	        File file = new File(fullPath);
	        if (file.exists() && file.delete()) {
//	            System.out.println("파일 삭제 성공: " + fullPath);
	        } else {
//	            System.out.println("파일 삭제 실패 또는 파일이 존재하지 않음: " + fullPath);
	        }
	    }

	    // 4. 데이터베이스에서 이미지 정보 삭제
	    RDao.deleteReviewImagesByReviewNo(reviewNo);

	    // 5. 데이터베이스에서 리뷰 삭제
	    RDao.deleteReview(reviewNo);
	    
	}
}

	