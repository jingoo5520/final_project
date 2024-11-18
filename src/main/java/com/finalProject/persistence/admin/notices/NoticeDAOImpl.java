package com.finalProject.persistence.admin.notices;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.PagingInfo;
import com.finalProject.model.admin.notices.PagingInfoDTO;
import com.finalProject.model.admin.notices.PagingInfoNotice;
import com.finalProject.model.admin.notices.SearchCriteriaDTO;

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
	public void addEvent(NoticeDTO event) throws Exception {
//		System.out.println(ses.insert(ns + "addEvent", notice)); // 1
		ses.insert(ns + "addEvent", event);
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

//	@Override
//	public List<NoticeDTO> getNoticesWithPagination(int offset, int limit) throws Exception {
//	    return ses.selectList(ns + "getAllNotices", Map.of("offset", offset, "limit", limit));
//	}
	
//	@Override
//	public List<NoticeDTO> getNoticesWithPagination(int offset, int limit) throws Exception {
//	    Map<String, Object> params = new HashMap<>();
//	    params.put("offset", offset);
//	    params.put("limit", limit);
//	    return ses.selectList(ns + "getAllNotices", params);
//	}

	@Override
	public List<NoticeDTO> getNotices(SearchCriteriaDTO criteria, PagingInfoDTO pagingInfoDTO) throws Exception {
	    // 전체 공지사항 수를 가져옵니다.
	    int totalPostCnt = ses.selectOne(ns + "countNotices", criteria); // 'countNotices'는 공지사항 수를 세는 쿼리입니다.

	    // PagingInfo 객체를 생성하고 설정합니다.
	    PagingInfo pagingInfo = new PagingInfo(pagingInfoDTO);
	    pagingInfo.setTotalPageCnt(totalPostCnt); // criteria는 필요하지 않으므로 삭제
	    pagingInfo.setTotalPageCnt(); // 총 페이지 수 계산
	    pagingInfo.setStartRowIndex(); // 시작 인덱스 계산

	    // 공지사항을 조회합니다.
	    Map<String, Object> params = new HashMap<>();
	    params.put("criteria", criteria);
	    params.put("startRowIndex", pagingInfo.getStartRowIndex());
	    params.put("viewPostCntPerPage", pagingInfo.getViewPostCntPerPage());

	    return ses.selectList(ns + "selectNotices", params);
	}

	//	@Override
//	public void createEventImg(NoticeDTO noticeDTO) throws Exception {
//	    System.out.println("NoticeDTO: " + noticeDTO);
//		ses.insert(ns + "createEventImg", noticeDTO);
//	}

	@Override
	public void saveBannerPath(int noticeNo, String filePath) throws Exception {
	    try {
		Map<String, Object> params = new HashMap<>();
	    params.put("notice_no", noticeNo);
	    params.put("banner_image", filePath);
	    ses.update(ns + "updateBannerPath", params);
	    System.out.println("Saving banner path: " + filePath);

	    } catch (Exception e) {
	    	e.printStackTrace();
	    	throw e;
	    }

	}

	@Override
	public void saveThumbnailPath(int noticeNo, String filePath) throws Exception {
	    try {
		Map<String, Object> params = new HashMap<>();
	    params.put("notice_no", noticeNo);
	    params.put("thumbnail_image", filePath);
		ses.update(ns + "updateThumbnailPath", params);
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	throw e;
	    }
	}

	@Override
	public void saveUrl(int noticeNo, String url) throws Exception {
	    try {
		Map<String, Object> params = new HashMap<>();
	    params.put("notice_no", noticeNo);
	    params.put("url", url);
	    ses.update(ns + "updateurl", params);
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	throw e;
	    }

	}

	@Override
	public void saveEvent(NoticeDTO event) throws Exception {
		ses.insert(ns + "insertEvent", event);
	}

	@Override
	public void updateBannerPath(int noticeNo, String bannerImage) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("noticeNo", noticeNo);
        params.put("bannerImage", bannerImage);
        int result = ses.update(ns + "updateBannerPath2", params);
        System.out.println("result : " + result);
	}

	@Override
	public void updateThumbnailPath(int noticeNo, String thumbnailImage) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("noticeNo", noticeNo);
        params.put("thumbnailImage", thumbnailImage);
        int result = ses.update(ns + "updateThumbnailPath", params);
        System.out.println("result : " + result);
	}

	@Override
	public boolean deleteThumbnail(int noticeNo) throws Exception {
	    int deleteTumb = ses.delete(ns + "deleteThumbnail", noticeNo); // noticeNo를 직접 사용
	    return deleteTumb > 0; // 삭제된 행 수가 0보다 크면 true..
	}

	@Override
	public List<NoticeDTO> getBannersWithImages() throws Exception {
		return ses.selectList(ns + "getBannersWithImages");
	}

	@Override
	public boolean updateNoticeUrl(NoticeVO notice) {
	    try {
	        // URL 업데이트 쿼리 실행
	        ses.update("updateUrl", notice); // updateUrl은 mapper XML에서 정의한 쿼리 ID
	        return true;  // 성공 시 true 반환
	    } catch (Exception e) {
	        // 예외 발생 시 false 반환
	        e.printStackTrace();
	        return false;
	    }
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
