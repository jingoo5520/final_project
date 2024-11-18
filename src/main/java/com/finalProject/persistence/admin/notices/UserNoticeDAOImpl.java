package com.finalProject.persistence.admin.notices;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeTypeStatus.NoticeType;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.PagingInfoNotice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Mapper
@Repository
public class UserNoticeDAOImpl implements UserNoticeDAO {

    @Autowired
	private SqlSession ses;
	
	private String ns = "com.finalProject.mappers.userNoticeMapper.";

    @Override
    public List<NoticeDTO> getNoticesByType(NoticeType noticeType) throws Exception {
        return ses.selectList(ns + "getNotices", noticeType);
    }

    @Override
    public NoticeDTO getNoticeDetail(int noticeNo) throws Exception {
        return ses.selectOne(ns + "getNoticeById", noticeNo);
    }

    @Override
    public List<NoticeDTO> getEventsByType(NoticeType noticeType) throws Exception {
        return ses.selectList(ns + "getEvents", noticeType);
    }

    @Override
    public NoticeDTO getEventDetail(int noticeNo) throws Exception {
        return ses.selectOne(ns + "getEventById", noticeNo);
    }

	@Override
	public int getTotalPostCnt() throws Exception {
		return ses.selectOne(ns + "getTotalPostCount");
	}

	@Override
	public List<NoticeDTO> getALLNotices(int pagingSize, int startRowIndex) throws Exception {
        Map<String, Integer> params = new HashMap<>();
        params.put("pagingSize", pagingSize);
        params.put("startRowIndex", startRowIndex);
        return ses.selectList(ns + "getAllNotices", params);
	}

	@Override
	public List<NoticeDTO> getAllEvents(int pagingSize, int startRowIndex) throws Exception {
        Map<String, Integer> params = new HashMap<>();
        params.put("pagingSize", pagingSize);
        params.put("startRowIndex", startRowIndex);
        return ses.selectList(ns + "getAllEvents", params);
	}

	@Override
	public int getTotalNoticeCnt() throws Exception {
		return ses.selectOne(ns + "selectNoticeCnt");
	}

	@Override
	public List<NoticeDTO> selectNoticeList(PagingInfoNotice pi) throws Exception {
		return ses.selectList(ns + "selectNoticeList", pi);
	}

	@Override
	public int getTotalEventCnt() throws Exception {
		return ses.selectOne(ns + "selectEventCnt");
	}

	@Override
	public List<NoticeDTO> selectEventList(PagingInfoNotice pi) throws Exception {
		return ses.selectList(ns + "selectEventList", pi);
	}

//	@Override
//	public List<NoticeDTO> getNoticesByType(String string) throws Exception {
//		return ses.selectList(ns + "getNotices", string);
//	}

}
