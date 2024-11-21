package com.finalProject.service.admin.black;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.black.BlackInsertDTO;
import com.finalProject.model.admin.black.BlackMemberDTO;
import com.finalProject.model.admin.product.PagingInfo;
import com.finalProject.model.admin.product.adminPagingInfoDTO;
import com.finalProject.persistence.admin.black.BlackDAO;

@Service
public class BlackServiceImpl implements BlackService {
	@Autowired
	private BlackDAO bDAO;

	@Override
	public Map<String, Object> getAllMember(adminPagingInfoDTO dto) throws Exception {

		PagingInfo pi = makePagingInfo(dto);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("PagingInfo", pi);
		map.put("MemberList", bDAO.getAllMember(pi));
		return map;
	}

	private PagingInfo makePagingInfo(adminPagingInfoDTO dto) throws Exception {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(bDAO.getTotalPostCnt());

		pi.setTotalPageCnt(); // �쟾泥� �럹�씠吏� �닔 �꽭�똿
		pi.setStartRowIndex(); // �쁽�옱 �럹�씠吏��뿉�꽌 蹂댁뿬二쇨린 �떆�옉�븷 湲��쓽 index踰덊샇

		// �럹�씠吏� 釉붾윮
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

		mapperMap.put("reg_date_start", bm.getReg_date_start());
		mapperMap.put("reg_date_end", bm.getReg_date_end());
		mapperMap.put("isBlack", bm.getBlack());
		System.out.println(bm.getBlack());
		pi.setTotalPostCnt(bDAO.getSearchTotalPostCnt(mapperMap));

		pi.setTotalPageCnt(); // �쟾泥� �럹�씠吏� �닔 �꽭�똿
		pi.setStartRowIndex(); // �쁽�옱 �럹�씠吏��뿉�꽌 蹂댁뿬二쇨린 �떆�옉�븷 湲��쓽 index踰덊샇

		// �럹�씠吏� 釉붾윮
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
	      Map<String, Object> maps = new HashMap<String, Object>();
	      List<String> list = map.get("MemberIdList");
	      System.out.println(list);

	      if (updateCount >= 1) {
	         for (int i = 0; i < map.size(); i++) {
	            maps.put("reason", "관리자 블랙");
	            maps.put("admin", "admin1");
	            maps.put("member", list.get(i));
	            bDAO.insertBlackMembers(maps);
	         }

	      }
	      if (updateCount < map.size()) {
	         throw new Exception("fail");

	      }
	      return true;
	   } 

	@Override
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public boolean blackCancelMember(String memberId) {
		// TODO Auto-generated method stub
		int result = 0;
		int result1 = 0;
		if (memberId != null && memberId != "") {
			result = bDAO.deleteBlackMember(memberId);
			result1 = bDAO.blackCancelMember(memberId);
		}
		if (result >= 0 && result1 >= 0) {
			return true;
		} else {
			return false;
		}
	}

}
