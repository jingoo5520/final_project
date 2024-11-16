package com.finalProject.persistence.admin.notices;

import java.util.List;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.PagingInfo;
import com.finalProject.model.admin.notices.PagingInfoDTO;
import com.finalProject.model.admin.notices.PagingInfoNotice;
import com.finalProject.model.admin.notices.SearchCriteriaDTO;

public interface NoticeDAO {

	// 공지사항 목록 조회
	List<NoticeDTO> getAllNotices(int pagingSize, int startRowIndex) throws Exception;

	// 이벤트 목록 조회
	List<NoticeDTO> getAllEvents(int pagingSize, int startRowIndex) throws Exception;

	// 공지사항 저장
	void addNotice(NoticeVO notice) throws Exception;

	// 이벤트 저장
	void addEvent(NoticeDTO event) throws Exception;

	// 공지사항 수정 조회
	NoticeDTO selectNoticeById(int noticeNo) throws Exception;

	// 이벤트 수정 조회
	NoticeDTO selectEventById(int noticeNo) throws Exception;

	// 공지사항 수정
	void updateNotice(NoticeDTO noticeDTO) throws Exception;

	// 이벤트 수정
	void updateEvent(NoticeDTO noticeDTO) throws Exception;

	// 공지사항 삭제
	void deleteNotice(int noticeNo) throws Exception;

	// 이벤트 삭제
	void deleteEvent(int noticeNo) throws Exception;

	// 전체 글(데이터) 수
	int getTotalPostCnt() throws Exception;
	
	// 페이지네이션이 적용된 공지 목록 조회
//	List<NoticeDTO> getNoticesWithPagination(int offset, int limit) throws Exception;

	// 페이지네이션 검색어 처리
	List<NoticeDTO> getNotices(SearchCriteriaDTO criteria, PagingInfoDTO pagingInfoDTO) throws Exception;

	// 이벤트 DB 저장 로직
//	void createEventImg(NoticeDTO noticeDTO) throws Exception;

	// 배너 이미지 저장
	void saveBannerPath(int noticeNo, String filePath) throws Exception;

	// 썸네일 이미지 저장
	void saveThumbnailPath(int noticeNo, String filePath) throws Exception;

	// url 저장
	void saveUrl(int noticeNo, String url) throws Exception;

	// 썸네일 이미지 저장
	void saveEvent(NoticeDTO event) throws Exception;

	// 배너 이미지 수정
	void updateBannerPath(int noticeNo, String bannerImage) throws Exception;

	// 썸네일 이미지 수정
	void updateThumbnailPath(int noticeNo, String thumbnailImage) throws Exception;

	// 썸네일 이미지 삭제
	boolean deleteThumbnail(int noticeNo) throws Exception;

	// 메인 배너
	List<NoticeDTO> getBannersWithImages() throws Exception;

	// url
	boolean updateNoticeUrl(NoticeVO notice) throws Exception;

	// 공지 페이지네이션
	int getTotalNoticeCnt() throws Exception;
	List<NoticeDTO> selectNoticeList(PagingInfoNotice pi) throws Exception;

	// 이벤트 페이지네이션
	int getTotalEventCnt() throws Exception;
	List<NoticeDTO> selectEventList(PagingInfoNotice pi) throws Exception;




	
	// 페이지네이션 -> 페이징
//	List<NoticeVO> selectAllBoard(PagingInfo pi) throws Exception;

	// 게시글 목록 조회 -> 검색어
//	List<NoticeVO> selectAllBoard(SearchCriteriaDTO searchCriteriaDTO) throws Exception;
	
	// 검색된 게시글 수
//	int getTotalPostCnt(SearchCriteriaDTO sc) throws Exception;
	
	// 페이징 + 검색어
//	List<NoticeVO> selectAllBoard(PagingInfo pi, SearchCriteriaDTO sc) throws Exception;
	





}
