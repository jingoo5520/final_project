package com.finalProject.persistence.admin.notices;

import java.util.List;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeTypeStatus.NoticeType;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.PagingInfoNotice;

public interface UserNoticeDAO {

    // 공지사항 타입에 따라 목록 조회
    List<NoticeDTO> getNoticesByType(NoticeType noticeType) throws Exception;

    // 공지사항 상세 조회
    NoticeDTO getNoticeDetail(int noticeNo) throws Exception;

    // 이벤트 타입에 따라 목록 조회
    List<NoticeDTO> getEventsByType(NoticeType noticeType) throws Exception;

    // 이벤트 상세 조회
    NoticeDTO getEventDetail(int noticeNo) throws Exception;

	int getTotalPostCnt() throws Exception;

	List<NoticeDTO> getALLNotices(int pagingSize, int startRowIndex) throws Exception;

	List<NoticeDTO> getAllEvents(int pagingSize, int startRowIndex) throws Exception;

	int getTotalNoticeCnt() throws Exception;

	List<NoticeDTO> selectNoticeList(PagingInfoNotice pi) throws Exception;

	int getTotalEventCnt() throws Exception;

	List<NoticeDTO> selectEventList(PagingInfoNotice pi) throws Exception;

//	List<NoticeDTO> getNoticesByType(String string) throws Exception;
	
}
