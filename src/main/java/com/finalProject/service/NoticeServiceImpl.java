package com.finalProject.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.PagingInfo;
import com.finalProject.model.admin.notices.PagingInfoDTO;
import com.finalProject.model.admin.notices.SearchCriteriaDTO;
import com.finalProject.persistence.admin.notices.NoticeDAO;
import com.mysql.cj.util.StringUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDAO nDao;

	@Override
	public List<NoticeDTO> getAllNotices(int pagingSize, int startRowIndex) throws Exception {
		log.info("NoticeServiceImpl!!!");
		return nDao.getAllNotices(pagingSize, startRowIndex);
	}

	@Override
	public List<NoticeDTO> getAllEvents(int pagingSize, int startRowIndex) throws Exception {
		System.out.println(nDao.getAllEvents(pagingSize, startRowIndex));
		return nDao.getAllEvents(pagingSize, startRowIndex);
	}

	@Transactional
	@Override
	public void addNotice(NoticeVO notice) throws Exception {
	    try {
	        nDao.addNotice(notice);
	    } catch (Exception e) {
	        log.error("공지사항 저장 실패: ", e);
	        throw e; // 예외를 다시 던져서 트랜잭션이 롤백되도록 함
	    }
	}

	@Transactional
	@Override
	public void addEvent(NoticeVO notice) throws Exception {
	    try {
	        nDao.addEvent(notice);
	    } catch (Exception e) {
	        log.error("이벤트 저장 실패: ", e);
	        throw e; // 예외를 다시 던져서 트랜잭션이 롤백되도록 함
	    }
	}

	@Override
	public NoticeDTO selectNoticeById(int noticeNo) throws Exception {
		return nDao.selectNoticeById(noticeNo);
	}

	@Override
	public NoticeDTO selectEventById(int noticeNo) throws Exception {
		return nDao.selectEventById(noticeNo);
	}

	@Override
	public void updateNotice(NoticeDTO noticeDTO) throws Exception {
		nDao.updateNotice(noticeDTO);
	}

	@Override
	public void updateEvent(NoticeDTO noticeDTO) throws Exception {
		nDao.updateEvent(noticeDTO);
	}

	@Override
	public void deleteNotice(int noticeNo) throws Exception {
		nDao.deleteNotice(noticeNo);
	}

	@Override
	public void deleteEvent(int noticeNo) throws Exception {
		nDao.deleteEvent(noticeNo);
	}

	@Override
	public int getTotalPostCnt() throws Exception {
		return nDao.getTotalPostCnt();
	}

	@Override
	public List<NoticeDTO> getNoticesWithPagination(int startRowIndex, int viewPostCntPerPage) throws Exception {
		return nDao.getNoticesWithPagination(startRowIndex, viewPostCntPerPage);
	}

//	@Override
//	public int getTotalNoticeCount() throws Exception {
//		return nDao.getTotalNoticeCount();
//	}
//
//	@Override
//	public List<NoticeDTO> getNotices(int currentPage, int pageSize) throws Exception {
//		return nDao.getNotices(currentPage, pageSize);
//	}

//	private PagingInfo makePagingInfo(PagingInfoDTO dto) throws Exception {
//		PagingInfo pi = new PagingInfo(dto);
//		
//		pi.setTotalPostCnt(nDao.getTotalPostCnt());
//		System.out.println("총 글의 갯수 : " + pi.getTotalPostCnt());
//		pi.setTotalPageCnt();
//		pi.setStartRowIndex();
//		
//		pi.setPageBlockNoCurPage();
//		pi.setStartPageNoCurBlock();
//		pi.setEndPageNoCurBlock();
//		
//		log.info("pagingInfo : " + pi.toString());
//		
//		return pi;
//	}
//	
//	@Override
//	public Map<String, Object> getAllnotices(PagingInfoDTO dto) throws Exception {
//		PagingInfo pi = makePagingInfo(dto);
//		List<NoticeVO> lst = nDao.selectAllBoard(pi);
//		
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap.put("pagingInfo", pi);
//		resultMap.put("boardList", lst);
//
//		return resultMap;
//	}
//	
//	private PagingInfo makePagingInfo(PagingInfoDTO dto) throws Exception {
//		PagingInfo pi = new PagingInfo(dto);
//		
//		pi.setTotalPostCnt(nDao.getTotalPostCnt()); // 검색된 글(데이터) 수
//		System.out.println("총 글의 갯수 : " + pi.getTotalPostCnt());
//
//		pi.setTotalPageCnt();
//		pi.setStartRowIndex();
//		
//		pi.setPageBlockNoCurPage();
//		pi.setStartPageNoCurBlock();
//		pi.setEndPageNoCurBlock();
//		
//		log.info("pagingInfo : " + pi.toString());
//		
//		return pi;
//	}
//
//	@Override
//	public Map<String, Object> getAllnotices(PagingInfoDTO dto, SearchCriteriaDTO searchCriteriaDTO) throws Exception {
//		PagingInfo pi = makePagingInfo(dto, searchCriteriaDTO);
////		List<NoticeVO> lst = nDao.selectAllBoard(pi);
//		
//		List<NoticeVO> lst = null;
//		
//		if (StringUtils.isNullOrEmpty(searchCriteriaDTO.getSearchType()) && StringUtils.isNullOrEmpty(searchCriteriaDTO.getSearchWord())) {
//			lst = nDao.selectAllBoard(pi);
//		} else {
//			lst = nDao.selectAllBoard(pi, searchCriteriaDTO);
//		}
//		
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap.put("pagingInfo", pi);
//		resultMap.put("boardList", lst);
//		
//		return resultMap;
//	}
//
//	private PagingInfo makePagingInfo(PagingInfoDTO dto, SearchCriteriaDTO sc) throws Exception {
//		PagingInfo pi = new PagingInfo(dto);
//		
//		log.info("검색된 글의 갯수 :" + nDao.getTotalPostCnt(sc));
//		pi.setTotalPostCnt(nDao.getTotalPostCnt(sc)); // 검색된 글(데이터) 수
//		
//		if (StringUtils.isNullOrEmpty(sc.getSearchType()) && StringUtils.isNullOrEmpty(sc.getSearchWord())) {
//			pi.setTotalPageCnt(nDao.getTotalPostCnt());
//		} else {
//			pi.setTotalPageCnt(nDao.getTotalPostCnt(sc));
//		}
//		
//		pi.setTotalPageCnt();
//		pi.setStartRowIndex();
//		
//		pi.setPageBlockNoCurPage();
//		pi.setStartPageNoCurBlock();
//		pi.setEndPageNoCurBlock();
//		
//		log.info("pagingInfo : " + pi.toString());
//		
//		return pi;
//	}


	


}
