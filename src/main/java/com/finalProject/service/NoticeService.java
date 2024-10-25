package com.finalProject.service;

import java.util.List;
import java.util.Map;

import com.finalProject.model.NoticeDTO;
import com.finalProject.model.NoticeVO;
import com.finalProject.model.PagingInfoDTO;
import com.finalProject.model.SearchCriteriaDTO;

public interface NoticeService {
	
	// 공지사항 목록 조회
	List<NoticeDTO> getAllNotices(int pagingSize, int startRowIndex) throws Exception;

	// 이벤트 목록 조회
	List<NoticeDTO> getAllEvents(int pagingSize, int startRowIndex) throws Exception;

	// 공지사항 작성
	void addNotice(NoticeVO notice) throws Exception;

	// 이벤트 작성
	void addEvent(NoticeVO notice) throws Exception;

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
    List<NoticeDTO> getNoticesWithPagination(int startRowIndex, int viewPostCntPerPage) throws Exception;

	
	// 페이지네이션
//	public int getTotalNoticeCount() throws Exception;
//	public List<NoticeDTO> getNotices(int currentPage, int pageSize) throws Exception;
	
	// 게시글 조회 -- 페이징
//	Map<String, Object> getAllnotices(PagingInfoDTO dto) throws Exception;

	// 게시글 조회 -- 검색어
//	Map<String, Object> getAllnotices(PagingInfoDTO dto, SearchCriteriaDTO searchCriteriaDTO) throws Exception;

}