package com.finalProject.service.admin.notices;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.PagingInfoDTO;
import com.finalProject.model.admin.notices.PagingInfoNoticeDTO;
import com.finalProject.model.admin.notices.SearchCriteriaDTO;

public interface NoticeService {
	
	// 공지사항 목록 조회
	Map<String, Object> getAllNotices(PagingInfoNoticeDTO pDto) throws Exception;

	// 이벤트 목록 조회
	Map<String, Object> getAllEvents(PagingInfoNoticeDTO pDto) throws Exception;

	// 공지사항 작성
	void addNotice(NoticeVO notice) throws Exception;

	// 이벤트 작성
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
//    List<NoticeDTO> getNoticesWithPagination(int startRowIndex, int viewPostCntPerPage) throws Exception;

    // 페이지네이션 검색어 처리
//    List<NoticeDTO> getNotices(SearchCriteriaDTO criteria, PagingInfoDTO pagingInfoDTO) throws Exception;
    
    // 이벤트 DB 저장 로직
//	void createEventImg(NoticeDTO noticeDTO) throws Exception;

	// 배너 이미지 저장
	void saveBannerPath(int noticeNo, String filePath) throws Exception;

	// 썸네일 이미지 저장
	void saveThumbnailPath(int noticeNo, String filePath) throws Exception;
	
	// url 저장
	void saveUrl(int noticeNo, String url) throws Exception;

	// 작성 페이지 썸네일 이미지 저장
	void saveEvent(NoticeDTO event) throws Exception;

	// 수정 페이지 배너 이미지 수정
	void updateBannerPath(int noticeNo, String newBannerPath) throws Exception;

	// 수정 페이지 썸네일 이미지 수정
	void updateThumbnailPath(int noticeNo, String newThumbnailPath) throws Exception;

	// 수정 페이지 썸네일 이미지 삭제
	boolean deleteThumbnail(int noticeNo) throws Exception;

	// 메인 배너
	List<NoticeDTO> getBannersWithImages() throws Exception;

	// url
	boolean updateNoticeUrl(NoticeVO notice) throws Exception;

	// 페이지네이션
	Map<String, Object> getNoticeList(PagingInfoNoticeDTO pagingInfoNoticeDTO) throws Exception;
	// 페이지네이션
	Map<String, Object> getEventList(PagingInfoNoticeDTO pagingInfoNoticeDTO) throws Exception;


	
	// 페이지네이션
//	public int getTotalNoticeCount() throws Exception;
//	public List<NoticeDTO> getNotices(int currentPage, int pageSize) throws Exception;
	
	// 게시글 조회 -- 페이징
//	Map<String, Object> getAllnotices(PagingInfoDTO dto) throws Exception;

	// 게시글 조회 -- 검색어
//	Map<String, Object> getAllnotices(PagingInfoDTO dto, SearchCriteriaDTO searchCriteriaDTO) throws Exception;

}