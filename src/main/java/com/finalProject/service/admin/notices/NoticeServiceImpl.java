package com.finalProject.service.admin.notices;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.PagingInfoNotice;
import com.finalProject.model.admin.notices.PagingInfoNoticeDTO;
import com.finalProject.persistence.admin.notices.NoticeDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO nDao;

	@Override
	public Map<String, Object> getAllNotices(PagingInfoNoticeDTO pDto) throws Exception {
		log.info("NoticeServiceImpl!!!");

		PagingInfoNotice pi = new PagingInfoNotice(pDto);

		// setter 호출
		pi.setTotalDataCnt(nDao.getTotalNoticeCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<NoticeDTO> list = nDao.selectNoticeList(pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	@Override
	public Map<String, Object> getAllEvents(PagingInfoNoticeDTO pDto) throws Exception {
		log.info("EventServiceImpl!!!");

		PagingInfoNotice pi = new PagingInfoNotice(pDto);

			// setter 호출
			pi.setTotalDataCnt(nDao.getTotalEventCnt());

			pi.setTotalPageCnt();
			pi.setStartRowIndex();

			// 페이징 블럭
			pi.setPageBlockNoCurPage();
			pi.setStartPageNoCurBloack();
			pi.setEndPageNoCurBlock();

			Map<String, Object> result = new HashMap<String, Object>();
			List<NoticeDTO> list = nDao.selectEventList(pi);

			result.put("pi", pi);
			result.put("list", list);

			return result;
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
	public void addEvent(NoticeDTO event) throws Exception {
		try {
			nDao.addEvent(event);
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

//	@Override
//	public List<NoticeDTO> getNoticesWithPagination(int startRowIndex, int viewPostCntPerPage) throws Exception {
//		return nDao.getNoticesWithPagination(startRowIndex, viewPostCntPerPage);
//	}
//
//	@Override
//	public List<NoticeDTO> getNotices(SearchCriteriaDTO criteria, PagingInfoDTO pagingInfoDTO) throws Exception {
//		return nDao.getNotices(criteria, pagingInfoDTO);
//	}

	// @Override
//	public void createEventImg(NoticeDTO noticeDTO) throws Exception{
//		nDao.createEventImg(noticeDTO);
//	}

	@Override
	public void saveBannerPath(int noticeNo, String filePath) throws Exception {
		nDao.saveBannerPath(noticeNo, filePath);
	}

	@Override
	public void saveThumbnailPath(int noticeNo, String filePath) throws Exception {
		nDao.saveThumbnailPath(noticeNo, filePath);
	}

	@Override
	public void saveUrl(int noticeNo, String url) throws Exception {
		nDao.saveUrl(noticeNo, url);
	}

	@Override
	public void saveEvent(NoticeDTO event) throws Exception {
		nDao.saveEvent(event);
	}

	@Transactional
	@Override
	public void updateBannerPath(int noticeNo, String newBannerPath) throws Exception {
		nDao.updateBannerPath(noticeNo, newBannerPath);
	}

	@Override
	public void updateThumbnailPath(int noticeNo, String newThumbnailPath) throws Exception {
		nDao.updateThumbnailPath(noticeNo, newThumbnailPath);

	}

	@Override
	public boolean deleteThumbnail(int noticeNo) throws Exception {
		return nDao.deleteThumbnail(noticeNo);
	}

	@Override
	public List<NoticeDTO> getBannersWithImages() throws Exception {
		return nDao.getBannersWithImages();
	}

	@Override
	public boolean updateNoticeUrl(NoticeVO notice) throws Exception {
		// DAO 호출 후 결과 반환
		boolean result = nDao.updateNoticeUrl(notice);
		return result; // true 또는 false 반환
	}

	@Override
	public Map<String, Object> getNoticeList(PagingInfoNoticeDTO pagingInfoNoticeDTO) throws Exception {
		PagingInfoNotice pi = new PagingInfoNotice(pagingInfoNoticeDTO);

		// setter 호출
		pi.setTotalDataCnt(nDao.getTotalNoticeCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<NoticeDTO> list = nDao.selectNoticeList(pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	@Override
	public Map<String, Object> getEventList(PagingInfoNoticeDTO pagingInfoNoticeDTO) throws Exception {
		PagingInfoNotice pi = new PagingInfoNotice(pagingInfoNoticeDTO);

		// setter 호출
		pi.setTotalDataCnt(nDao.getTotalEventCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<NoticeDTO> list = nDao.selectEventList(pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
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
