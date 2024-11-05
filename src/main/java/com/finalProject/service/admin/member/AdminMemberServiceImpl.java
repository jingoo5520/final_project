package com.finalProject.service.admin.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.member.MemberManageDTO;
import com.finalProject.model.admin.member.MemberSearchFilterDTO;
import com.finalProject.persistence.admin.member.AdminMemberDAO;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	@Inject
	AdminMemberDAO mDao;

	@Override
	public Map<String, Object> getAllMembers(PagingInfoNewDTO pagingInfoDTO) throws Exception {
		PagingInfoNew pi = makePagingInfo(pagingInfoDTO);

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

		PagingInfoNew pi = makePagingInfo(new PagingInfoNewDTO(pageNo, pagingSizeg, pageCntPerBlock), memberSearchFilterDTO);

		Map<String, Object> result = new HashMap<String, Object>();
		List<MemberManageDTO> list = mDao.selectFilteredMembers(memberSearchFilterDTO, pi);
		
		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	private PagingInfoNew makePagingInfo(PagingInfoNewDTO pagingInfoDTO) throws Exception {
		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);

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
	
	private PagingInfoNew makePagingInfo(PagingInfoNewDTO pagingInfoDTO, MemberSearchFilterDTO memberSearchFilterDTO) throws Exception {
		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);

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
