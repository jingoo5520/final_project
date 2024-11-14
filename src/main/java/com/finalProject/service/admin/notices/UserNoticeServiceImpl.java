package com.finalProject.service.admin.notices;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeTypeStatus.NoticeType;
import com.finalProject.persistence.admin.notices.UserNoticeDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserNoticeServiceImpl implements UserNoticeService {

    @Autowired
    private UserNoticeDAO unDAO;


    @Override
    public List<NoticeDTO> getNoticesByType(NoticeType noticeType) throws Exception {
        log.info("Fetching notices of type: {}", noticeType);
        List<NoticeDTO> notices = unDAO.getNoticesByType(noticeType);
        log.info("Notices fetched: {} items", notices.size()); // 리스트 개수 로깅
        
        if (notices == null || notices.isEmpty()) {
            log.warn("No notices found for type: {}", noticeType);
        }
        
        return notices;
    }
    
    @Override
    public NoticeDTO getNoticeDetail(int noticeNo) throws Exception {
        log.info("Fetching notice detail for noticeNo: {}", noticeNo);
        NoticeDTO notice = unDAO.getNoticeDetail(noticeNo);
        
        if (notice == null) {
            log.warn("No notice found for noticeNo: {}", noticeNo);
        } else {
            log.info("Notice detail fetched: {}", notice);
        }
        
        return notice;
    }

    @Override
    public List<NoticeDTO> getEventsByType(NoticeType noticeType) throws Exception {
        log.info("Fetching events of type: {}", noticeType);
        List<NoticeDTO> events = unDAO.getEventsByType(noticeType);
        log.info("Events fetched: {} items", events.size()); // 리스트 개수 로깅
        
        if (events == null || events.isEmpty()) {
            log.warn("No events found for type: {}", noticeType);
        }
        
        return events;
    }

    @Override
    public NoticeDTO getEventDetail(int noticeNo) throws Exception {
        log.info("Fetching event detail for noticeNo: {}", noticeNo);
        NoticeDTO event = unDAO.getEventDetail(noticeNo);
        
        if (event == null) {
            log.warn("No event found for noticeNo: {}", noticeNo);
        } else {
            log.info("Event detail fetched: {}", event);
        }
        
        return event;
    }

	@Override
	public int getTotalPostCnt() throws Exception {
		return unDAO.getTotalPostCnt();
	}

	@Override
	public List<NoticeDTO> getAllNotices(int pagingSize, int startRowIndex) throws Exception {
		return unDAO.getALLNotices(pagingSize, startRowIndex);
	}

	@Override
	public List<NoticeDTO> getAllEvents(int pagingSize, int startRowIndex) throws Exception {
		return unDAO.getAllEvents(pagingSize, startRowIndex);
	}

//	@Override
//	public List<NoticeDTO> getNotices(String string) throws Exception {
//		return unDAO.getNoticesByType(string);
//	}

}
