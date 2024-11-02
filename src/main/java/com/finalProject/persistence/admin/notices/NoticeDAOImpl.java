package com.finalProject.persistence.admin.notices;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Mapper
@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	private SqlSession ses;
	
	private String ns = "com.finalProject.mappers.noticeMapper.";

	@Override
	public List<NoticeDTO> getAllNotices(int pagingSize, int startRowIndex) throws Exception {
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
	public void addNotice(NoticeVO notice) throws Exception {
		log.info("notice: {}", notice);
		ses.insert(ns + "addNotice", notice);
	}

	@Override
	public void addEvent(NoticeVO notice) throws Exception {
//		System.out.println(ses.insert(ns + "addEvent", notice)); // 1
		ses.insert(ns + "addEvent", notice);
	}

	@Override
	public NoticeDTO selectNoticeById(int noticeNo) throws Exception {
		return ses.selectOne(ns + "selectNoticeById", noticeNo);
	}

	@Override
	public NoticeDTO selectEventById(int noticeNo) throws Exception {
//		System.out.println("DAOImpl noticeNo: " + noticeNo);
//		NoticeDTO notice = ses.selectOne(ns + "selectEventById", noticeNo);
//		System.out.println("DAOImpl: Selected Notice: " + notice);
		return ses.selectOne(ns + "selectEventById", noticeNo);
	}

	@Override
	public void updateNotice(NoticeDTO noticeDTO) throws Exception {
		ses.update(ns + "updateNotice", noticeDTO);
	}

	@Override
	public void updateEvent(NoticeDTO noticeDTO) throws Exception {
		System.out.println(ses.update(ns + "updateEvent", noticeDTO));
		ses.update(ns + "updateEvent", noticeDTO);
	}

	@Override
	public void deleteNotice(int noticeNo) throws Exception {
		ses.update(ns + "deleteNotice", noticeNo);
		
	}

	@Override
	public void deleteEvent(int noticeNo) throws Exception {
		ses.update(ns + "deleteEvent", noticeNo);
	}

//	@Override
//	public int getTotalNoticeCount() throws Exception {
//		System.out.println(getTotalNoticeCount());
//		int count = ses.selectOne(ns + "getTotalNoticeCount");
//		System.out.println(count);
//		return count;
//	}
//
//	@Override
//	public List<NoticeDTO> getNotices(int currentPage, int pageSize) throws Exception {
//		int startIndex = (currentPage - 1) * pageSize;
//		
//		Map<String, Object> params = new HashMap<>();
//		params.put("startIndex", startIndex);
//		params.put("pageSize", pageSize);
//		System.out.println(ses.selectList(ns + "getNotices", params));
//		return ses.selectList(ns + "getNotices", params);
//	}

	@Override
	public int getTotalPostCnt() throws Exception {
		return ses.selectOne(ns + "getTotalPostCount");
	}

	@Override
	public List<NoticeDTO> getNoticesWithPagination(int offset, int limit) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("limit", limit);
	    return ses.selectList(ns + "getAllNotices", params);
	}

//	@Override
//	public List<NoticeVO> selectAllBoard(PagingInfo pi) throws Exception {
//		return ses.selectList(ns + "getSearchNotice", pi);
//	}
//
//	@Override
//	public List<NoticeVO> selectAllBoard(SearchCriteriaDTO searchCriteriaDTO) throws Exception {
//		return ses.selectOne(ns + "getSearchBoard", searchCriteriaDTO);
//	}
//
//	@Override
//	public int getTotalPostCnt(SearchCriteriaDTO sc) throws Exception {
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("searchType", sc.getSearchType() + "%");
//		params.put("searchWord", "%" + sc.getSearchWord() + "%");
//		return ses.selectOne(ns + "selectTotalCountWithSearchCriteria", params);
//	}
//
//	@Override
//	public List<NoticeVO> selectAllBoard(PagingInfo pi, SearchCriteriaDTO sc) throws Exception {
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("startRowIndex", pi.getStartRowIndex());
//		params.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
//		params.put("searchType", sc.getSearchType());
//		params.put("searchWord", "%" + sc.getSearchWord() + "%");
//		return ses.selectList(ns + "getAllNotice", pi);
//	}







	
	
}
