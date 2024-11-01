package com.finalProject.service.admin.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.persistence.admin.inquiry.AdminInquiryDAO;

@Service
public class AdminInquiryServiceImpl implements AdminInquiryService {

	@Inject
	AdminInquiryDAO aiDao;
	
	@Override
	public Map<String, Object> getInquiryList(PagingInfoNewDTO pagingInfoDTO) throws Exception {
		
		PagingInfoNew pi = makePagingInfo(pagingInfoDTO);
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<InquiryDetailDTO> list = aiDao.selectInquiryList(pi);

		result.put("pi", pi);
		result.put("list", list);
		
		return result;
	}
	
	private PagingInfoNew makePagingInfo(PagingInfoNewDTO pagingInfoDTO) throws Exception {
		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);

		// setter 호출
		pi.setTotalDataCnt(aiDao.getTotalInquiryCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		return pi;
	}

}
