package com.finalProject.service.admin.black;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.black.BlackMemberDTO;
import com.finalProject.model.admin.product.PagingInfo;
import com.finalProject.model.admin.product.ProductPagingInfoDTO;
import com.finalProject.persistence.admin.black.BlackDAO;

@Service
public class BlackServiceImpl implements BlackService {
	@Autowired
	private BlackDAO bDAO;

	@Override
	public Map<String, Object> getAllMember(ProductPagingInfoDTO dto) throws Exception {

		PagingInfo pi = makePagingInfo(dto);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("PagingInfo", pi);
		map.put("MemberList", bDAO.getAllMember(pi));
		return map;
	}

	private PagingInfo makePagingInfo(ProductPagingInfoDTO dto) throws Exception {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(bDAO.getTotalPostCnt());

		pi.setTotalPageCnt(); // 전체 페이지 수 세팅
		pi.setStartRowIndex(); // 현재 페이지에서 보여주기 시작할 글의 index번호

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		return pi;
	}

	private PagingInfo makePagingInfo(BlackMemberDTO bm) throws Exception {
		PagingInfo pi = new PagingInfo(bm);
		Map<String, Object> mapperMap = new HashMap<String, Object>();
		mapperMap.put("gender_list", bm.getGender_list());
		mapperMap.put("level_list", bm.getLevel_list());
		mapperMap.put("member_id", bm.getMember_id());
		mapperMap.put("member_name", bm.getMember_name());
		mapperMap.put("birthday_start", bm.getBirthday_start());
		mapperMap.put("birthday_end", bm.getBirthday_end());
		mapperMap.put("reg_date_start", bm.getReg_date_start());
		mapperMap.put("reg_date_end", bm.getReg_date_end());
		mapperMap.put("isBlack", bm.getBlack());
		pi.setTotalPostCnt(bDAO.getSearchTotalPostCnt(mapperMap));

		pi.setTotalPageCnt(); // 전체 페이지 수 세팅
		pi.setStartRowIndex(); // 현재 페이지에서 보여주기 시작할 글의 index번호

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		return pi;
	}

	@Override
	public Map<String, Object> getSearchMember(BlackMemberDTO bm) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> mapperMap = new HashMap<String, Object>();
		mapperMap.put("gender_list", bm.getGender_list());
		mapperMap.put("level_list", bm.getLevel_list());
		mapperMap.put("member_id", bm.getMember_id());
		mapperMap.put("member_name", bm.getMember_name());
		mapperMap.put("birthday_start", bm.getBirthday_start());
		mapperMap.put("birthday_end", bm.getBirthday_end());
		mapperMap.put("reg_date_start", bm.getReg_date_start());
		mapperMap.put("reg_date_end", bm.getReg_date_end());
		mapperMap.put("isBlack", (String) bm.getBlack());
		PagingInfo pi = makePagingInfo(bm);
		mapperMap.put("startRowIndex", pi.getStartRowIndex());
		mapperMap.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
		map.put("PagingInfo", pi);
		map.put("MemberList", bDAO.getSearchMember(mapperMap));
		return map;
	}

	@Override
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public boolean blackMember(Map<String, List<String>> map) throws Exception {
		int updateCount = bDAO.blackMember(map);

		if (updateCount < map.size()) {
			throw new Exception("fail");

		}
		return true;
	}

}
