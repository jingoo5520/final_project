package com.finalProject.service.admin.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.inquiry.InquiryReplyDTO;
import com.finalProject.model.admin.inquiry.InquirySearchFilterDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.model.inquiry.InquiryImgDTO;
import com.finalProject.persistence.admin.inquiry.AdminInquiryDAO;

@Service
public class AdminInquiryServiceImpl implements AdminInquiryService {

	@Inject
	AdminInquiryDAO aiDao;
	
	@Override
	public Map<String, Object> getInquiryList(PagingInfoNewDTO pagingInfoDTO) throws Exception {
		
		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);
		
		pi.setTotalDataCnt(aiDao.getTotalInquiryCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<InquiryDetailDTO> list = aiDao.selectInquiryList(pi);

		result.put("pi", pi);
		result.put("list", list);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getInquiry(int inquiryNo) throws Exception {
		InquiryDetailDTO inquiryDetail = aiDao.selectInquiry(inquiryNo);
		List<InquiryImgDTO> inquiryImages = aiDao.selectInquiryImages(inquiryNo);
		InquiryReplyDTO inquiryReplyDTO = aiDao.selectInquiryReply(inquiryNo);

		Map<String, Object> result = new HashMap<String, Object>();

		result.put("inquiryDetail", inquiryDetail);
		result.put("inquiryImgList", inquiryImages);
		result.put("inquiryReply", inquiryReplyDTO);

		return result;
	}

	@Override
	@Transactional
	public int writeInquiryReply(InquiryReplyDTO dto) throws Exception {
		int result = 0;
		
		// 신규 작성
		if(dto.getInquiry_reply_no() == 0) {
			
			result = aiDao.insertInquiryReply(dto);
			aiDao.updateInquiryStatus(dto.getInquiry_no());
		} else {
			result = aiDao.updateInquiryReply(dto);
		}
		return result; 
	}

	@Override
	public Map<String, Object> getFilterdInquiryList(InquirySearchFilterDTO dto) throws Exception {
		int pageNo = dto.getPageNo();
		int pagingSizeg = dto.getPagingSize();
		int pageCntPerBlock = dto.getPageCntPerBlock();
		
		PagingInfoNew pi = new PagingInfoNew(new PagingInfoNewDTO(pageNo, pagingSizeg, pageCntPerBlock));
		
		pi.setTotalDataCnt(aiDao.getTotalFilterdInquiryCnt(dto));

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<InquiryDetailDTO> list = aiDao.selectFilteredInquiryList(dto, pi);

		result.put("pi", pi);
		result.put("list", list);
		
		return result;
	}

}
