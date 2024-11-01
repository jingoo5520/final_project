package com.finalProject.service.admin.orders;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.order.AdminCancleVO;
import com.finalProject.model.admin.order.CancelSearchDTO;
import com.finalProject.model.admin.product.PagingInfo;
import com.finalProject.model.admin.product.adminPagingInfoDTO;
import com.finalProject.persistence.admin.order.OrdersDAO;

@Service
public class OrdersServiceImpl implements OrdersService {

	@Autowired
	private OrdersDAO oDAO;

	@Override
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public Map<String, Object> getAllCancle(adminPagingInfoDTO dto) throws Exception {
		// TODO Auto-generated method stub
		PagingInfo pagingInfo = makePagingInfo(dto);
		List<AdminCancleVO> list;
		List<AdminCancleVO> topList;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Integer> pageMap = new HashMap<String, Integer>();
		pageMap.put("startRowIndex", pagingInfo.getStartRowIndex());
		pageMap.put("viewPostCntPerPage", pagingInfo.getViewPostCntPerPage());
		try {
			list = oDAO.getAllCancle(pageMap);
			topList = oDAO.getTopCancle();

			resultMap.put("CancleList", list);
			resultMap.put("PagingInfo", pagingInfo);
			resultMap.put("TopCancleList", topList);

			return resultMap;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return resultMap;
	}

	private PagingInfo makePagingInfo(adminPagingInfoDTO dto) throws Exception {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(oDAO.getTotalPostCnt());

		pi.setTotalPageCnt(); // 전체 페이지 수 세팅
		pi.setStartRowIndex(); // 현재 페이지에서 보여주기 시작할 글의 index번호

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		return pi;
	}

	@Override
	public Map<String, Object> getSearchFilter(CancelSearchDTO search, adminPagingInfoDTO dto) throws Exception {
		PagingInfo pagingInfo = makePagingInfo(dto);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<AdminCancleVO> li = new ArrayList<AdminCancleVO>();
		resultMap.put("cancel_type", search.getCancel_type());
		resultMap.put("cancel_status", search.getCancel_status());
		resultMap.put("cancel_apply_date_start", search.getCancel_apply_date_start());
		resultMap.put("cancel_apply_date_end", search.getCancel_apply_date_end());
		resultMap.put("startRowIndex", pagingInfo.getStartRowIndex());
		resultMap.put("viewPostCntPerPage", pagingInfo.getViewPostCntPerPage());
		li = oDAO.getSearchFilter(resultMap);
		System.out.println(li);
		returnMap.put("CancelList", li);
		returnMap.put("PagingInfo", pagingInfo);

		return returnMap;
	}

}
