package com.finalProject.service.admin.notices;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.PagingInfoNoticeDTO;
import com.finalProject.model.admin.notices.NoticeTypeStatus.NoticeType;

public interface UserNoticeService {

    // 공지 조회
	Map<String, Object> getAllNotices(PagingInfoNoticeDTO pDto) throws Exception;

    // 공지 상세 조회
    NoticeDTO getNoticeDetail(int noticeNo) throws Exception;

    // 이벤트 조회
	Map<String, Object> getAllEvents(PagingInfoNoticeDTO pDto) throws Exception;

    // 이벤트 상세 조회
    NoticeDTO getEventDetail(int noticeNo) throws Exception;

	int getTotalPostCnt() throws Exception;

	Map<String, Object> getUserNoticeList(PagingInfoNoticeDTO pDto) throws Exception;

	Map<String, Object> getUserEventList(PagingInfoNoticeDTO pDto) throws Exception;



//	List<NoticeDTO> getNotices(String string) throws Exception;

}
