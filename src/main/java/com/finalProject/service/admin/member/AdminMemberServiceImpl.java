package com.finalProject.service.admin.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.MemberManageDTO;
import com.finalProject.model.admin.MemberSearchFilterDTO;
import com.finalProject.model.admin.PagingInfo;
import com.finalProject.model.admin.PagingInfoDTO;
import com.finalProject.persistence.admin.AdminMemberDAO;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	@Inject
	AdminMemberDAO mDao;

	@Override
	public Map<String, Object> getAllMembers(PagingInfoDTO pagingInfoDTO) throws Exception {
		PagingInfo pi = makePagingInfo(pagingInfoDTO);

		Map<String, Object> result = new HashMap<String, Object>();
		List<MemberManageDTO> list = mDao.selectAllMembers(pi);

		result.put("pi", pi);
		result.put("list", list);

		System.out.println(result);

		return result;
	}

	@Override
	public Map<String, Object> getFilteredMembers(MemberSearchFilterDTO memberSearchFilterDTO) throws Exception {
		int pageNo = memberSearchFilterDTO.getPageNo();
		int pagingSizeg = memberSearchFilterDTO.getPagingSize();
		int pageCntPerBlock = memberSearchFilterDTO.getPageCntPerBlock();

		System.out.println("pageNo: " + pageNo);
		
		PagingInfo pi = makePagingInfo(new PagingInfoDTO(pageNo, pagingSizeg, pageCntPerBlock), memberSearchFilterDTO);

		Map<String, Object> result = new HashMap<String, Object>();
		List<MemberManageDTO> list = mDao.selectFilteredMembers(memberSearchFilterDTO, pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	private PagingInfo makePagingInfo(PagingInfoDTO pagingInfoDTO) throws Exception {
		PagingInfo pi = new PagingInfo(pagingInfoDTO);

		// setter 호출
		pi.setTotalDataCnt(mDao.getTotalMemberCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		return pi;
	}
	
	private PagingInfo makePagingInfo(PagingInfoDTO pagingInfoDTO, MemberSearchFilterDTO memberSearchFilterDTO) throws Exception {
		PagingInfo pi = new PagingInfo(pagingInfoDTO);

		// setter 호출
		pi.setTotalDataCnt(mDao.getTotalFilterdMemberCnt(memberSearchFilterDTO));

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		return pi;
	}

}
