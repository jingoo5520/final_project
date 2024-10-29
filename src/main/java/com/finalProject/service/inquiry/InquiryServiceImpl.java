package com.finalProject.service.inquiry;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.admin.PagingInfoNew;
import com.finalProject.model.admin.PagingInfoNewDTO;
import com.finalProject.model.inquiry.InquiryDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.persistence.inquiry.InquiryDAO;
import com.finalProject.util.FileProcess;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Inject
	InquiryDAO iDao;
	
	@Inject
	FileProcess fp;

	@Override
	public Map<String, Object> getInquiryList(PagingInfoNewDTO pagingInfoDTO, String memberId) throws Exception {

		PagingInfoNew pi = makePagingInfo(pagingInfoDTO);

		Map<String, Object> result = new HashMap<String, Object>();
		List<InquiryDTO> list = iDao.selectInquiryList(pi, memberId);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	private PagingInfoNew makePagingInfo(PagingInfoNewDTO pagingInfoDTO) throws Exception {
		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);

		// setter 호출
		pi.setTotalDataCnt(iDao.getTotalInquiryCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		return pi;
	}

	@Override
	public void writeInquiry(InquiryDetailDTO inquiryDetailDTO, MultipartFile[] files, HttpServletRequest request) throws Exception {

		System.out.println("inquiryDetailDTO: " + inquiryDetailDTO);
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/inquiryImages");
		System.out.println("서버의 실제 물리적 경로: " + realPath);
		
		String savePath = fp.makePath(realPath);
		System.out.println(savePath);
		
		for (MultipartFile file : files) {
			System.out.println(file.getOriginalFilename());
		}

		
		  
			  
		 

	}

}
