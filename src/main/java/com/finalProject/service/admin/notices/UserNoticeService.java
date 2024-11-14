package com.finalProject.service.admin.notices;

import java.util.List;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeTypeStatus.NoticeType;

public interface UserNoticeService {

    // 공지 조회
    List<NoticeDTO> getNoticesByType(NoticeType noticeType) throws Exception;

    // 공지 상세 조회
    NoticeDTO getNoticeDetail(int noticeNo) throws Exception;

    // 이벤트 조회
    List<NoticeDTO> getEventsByType(NoticeType noticeType) throws Exception;

    // 이벤트 상세 조회
    NoticeDTO getEventDetail(int noticeNo) throws Exception;

	int getTotalPostCnt() throws Exception;

	List<NoticeDTO> getAllNotices(int pagingSize, int startRowIndex) throws Exception;

	List<NoticeDTO> getAllEvents(int pagingSize, int startRowIndex) throws Exception;



//	List<NoticeDTO> getNotices(String string) throws Exception;

}
