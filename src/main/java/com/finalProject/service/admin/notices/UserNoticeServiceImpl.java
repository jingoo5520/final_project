package com.finalProject.service.admin.notices;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.PagingInfoNotice;
import com.finalProject.model.admin.notices.PagingInfoNoticeDTO;
import com.finalProject.persistence.admin.notices.UserNoticeDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserNoticeServiceImpl implements UserNoticeService {

    @Autowired
    private UserNoticeDAO unDAO;


    @Override
    public Map<String, Object> getAllNotices(PagingInfoNoticeDTO pDto) throws Exception {
    	log.info("UserNoticeServiceImpl!!!");

		PagingInfoNotice pi = new PagingInfoNotice(pDto);

		// setter 호출
		pi.setTotalDataCnt(unDAO.getTotalNoticeCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<NoticeDTO> list = unDAO.selectNoticeList(pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
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
    public Map<String, Object> getAllEvents(PagingInfoNoticeDTO pDto) throws Exception {
    	log.info("EventServiceImpl!!!");

		PagingInfoNotice pi = new PagingInfoNotice(pDto);

			// setter 호출
			pi.setTotalDataCnt(unDAO.getTotalEventCnt());

			pi.setTotalPageCnt();
			pi.setStartRowIndex();

			// 페이징 블럭
			pi.setPageBlockNoCurPage();
			pi.setStartPageNoCurBloack();
			pi.setEndPageNoCurBlock();

			Map<String, Object> result = new HashMap<String, Object>();
			List<NoticeDTO> list = unDAO.selectEventList(pi);

			result.put("pi", pi);
			result.put("list", list);

			return result;
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
	public Map<String, Object> getUserNoticeList(PagingInfoNoticeDTO pDto) throws Exception {
		log.info("NoticeServiceImpl!!!");

		PagingInfoNotice pi = new PagingInfoNotice(pDto);

		// setter 호출
		pi.setTotalDataCnt(unDAO.getTotalNoticeCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<NoticeDTO> list = unDAO.selectNoticeList(pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	@Override
	public Map<String, Object> getUserEventList(PagingInfoNoticeDTO pDto) throws Exception {
		log.info("EventServiceImpl!!!");

		PagingInfoNotice pi = new PagingInfoNotice(pDto);

			// setter 호출
			pi.setTotalDataCnt(unDAO.getTotalEventCnt());

			pi.setTotalPageCnt();
			pi.setStartRowIndex();

			// 페이징 블럭
			pi.setPageBlockNoCurPage();
			pi.setStartPageNoCurBloack();
			pi.setEndPageNoCurBlock();

			Map<String, Object> result = new HashMap<String, Object>();
			List<NoticeDTO> list = unDAO.selectEventList(pi);

			result.put("pi", pi);
			result.put("list", list);

			return result;
	}

//	@Override
//	public List<NoticeDTO> getNotices(String string) throws Exception {
//		return unDAO.getNoticesByType(string);
//	}

}
