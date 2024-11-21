package com.finalProject.service.inquiry;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.inquiry.InquiryReplyDTO;
import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.inquiry.InquiryDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.model.inquiry.InquiryImgDTO;
import com.finalProject.model.inquiry.InquiryProductDTO;
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

		PagingInfoNew pi = makePagingInfo(pagingInfoDTO, memberId);

		Map<String, Object> result = new HashMap<String, Object>();
		List<InquiryDTO> list = iDao.selectInquiryList(pi, memberId);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	private PagingInfoNew makePagingInfo(PagingInfoNewDTO pagingInfoDTO, String memberId) throws Exception {
		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);

		// setter 호출
		pi.setTotalDataCnt(iDao.getTotalInquiryCnt(memberId));

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		return pi;
	}

	@Override
	@Transactional
	public int writeInquiry(InquiryDetailDTO inquiryDetailDTO, MultipartFile[] files, HttpServletRequest request)
			throws Exception {
		int result = 0;

		List<InquiryImgDTO> list = null;

		String realPath = request.getSession().getServletContext().getRealPath(File.separator + "resources" + File.separator + "inquiryImages");

		result = iDao.insertInquiry(inquiryDetailDTO);

		System.out.println("files: " + files);
		System.out.println(files.length);

		if (files.length != 0) {
			int inquiryNo = iDao.selectMaxInquiryNo();

			System.out.println("inquiryNo: " + inquiryNo);

			list = fp.saveFiles(files, realPath);

			for (InquiryImgDTO inquiry : list) {
				inquiry.setInquiry_no(inquiryNo);
			}

			result = iDao.insertInquiryImages(list);
		}
		return result;
	}

	@Override
	@Transactional
	public Map<String, Object> getInquiry(int inquiryNo) throws Exception {
		InquiryDetailDTO inquiryDetail = iDao.selectInquiry(inquiryNo);
		List<InquiryImgDTO> inquiryImages = iDao.selectInquiryImages(inquiryNo);
		InquiryReplyDTO inquiryReplyDTO = iDao.selectInquiryReply(inquiryNo);

		Map<String, Object> result = new HashMap<String, Object>();

		result.put("inquiryDetail", inquiryDetail);
		result.put("inquiryImgList", inquiryImages);
		result.put("inquiryReply", inquiryReplyDTO);

		return result;
	}

	@Override
	@Transactional
	public int deleteInquiry(int inquiryNo, HttpServletRequest request) throws Exception {
		int result = 0;

		String realPath = request.getSession().getServletContext().getRealPath("/resources/inquiryImages");
		List<InquiryImgDTO> inquiryImages = iDao.selectInquiryImages(inquiryNo);
		iDao.deleteInquiryImages(inquiryNo);

		for (InquiryImgDTO imgDTO : inquiryImages) {
			String deleteFileName = realPath + imgDTO.getInquiry_image_uri().replace("\\resources\\inquiryImages", "");
			System.out.println("deleteFileName: " + deleteFileName);

			fp.deleteFile(deleteFileName);
		}

		result = iDao.deleteInquiry(inquiryNo);
		return result;
	}

	@Override
	@Transactional
	public int modifyInquiry(InquiryDetailDTO inquiryDetailDTO, MultipartFile[] files, String[] existFiles,
			HttpServletRequest request) throws Exception {

		int result = 0;

		// 새 이미지 파일들
		List<InquiryImgDTO> list = null;
		
		// 이미 존재했던 이미지 파일들
		List<String> existFileList = null;
		
		// 기존 이미지 파일들
		List<InquiryImgDTO> inquiryImages = iDao.selectInquiryImages(inquiryDetailDTO.getInquiry_no());
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/inquiryImages");
		result = iDao.updateInquiry(inquiryDetailDTO);
		
		// 기존 이미지 파일 제거
		if (existFiles != null) {
			
			existFileList = Arrays.asList(existFiles);
			
			for(InquiryImgDTO inquiryImgDTO : inquiryImages) {
				
				if(existFileList.contains(inquiryImgDTO.getInquiry_image_uri())) {
					
				} else {
					String deleteFileName = realPath + inquiryImgDTO.getInquiry_image_uri().replace("\\resources\\inquiryImages", "");
					
					System.out.println("inquiryImgDTO.getInquiry_image_no(): " + inquiryImgDTO.getInquiry_image_no());
					// DB삭제
					iDao.deleteInquiryImage(inquiryImgDTO.getInquiry_image_no());
					
					// 서버 삭제
					fp.deleteFile(deleteFileName);
				}
			}
		} else {
			result = iDao.deleteInquiryImages(inquiryDetailDTO.getInquiry_no());
			
			 for(InquiryImgDTO inquiryImgDTO : inquiryImages) {
				 String deleteFileName = realPath + inquiryImgDTO.getInquiry_image_uri().replace("\\resources\\inquiryImages", "");
				 fp.deleteFile(deleteFileName);
			 }
		}


		// 새 이미지 파일 등록 
		if (files != null && files.length != 0) {
			list = fp.saveFiles(files, realPath);

			for (InquiryImgDTO inquiry : list) {
				inquiry.setInquiry_no(inquiryDetailDTO.getInquiry_no());
			}
			
			result = iDao.insertInquiryImages(list);
		}

		return result;
	}

	@Override
	public List<InquiryProductDTO> getOrderdProducts(String memberId) throws Exception {
		return iDao.selectOrderedProducts(memberId);
	}

}
