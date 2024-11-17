package com.finalProject.service.admin.orders;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.order.AdminCancleVO;
import com.finalProject.model.admin.order.AdminGetCancel;
import com.finalProject.model.admin.order.AdminPayOrdererVO;
import com.finalProject.model.admin.order.AdminPaymentVO;
import com.finalProject.model.admin.order.AdminSearchRefundDTO;
import com.finalProject.model.admin.order.CancelSearchDTO;
import com.finalProject.model.admin.order.ModifyCancelStatusDTO;
import com.finalProject.model.admin.product.PagingInfo;
import com.finalProject.model.admin.product.adminPagingInfoDTO;
import com.finalProject.persistence.admin.order.OrdersDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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

		pi.setTotalPageCnt(); // �쟾泥� �럹�씠吏� �닔 �꽭�똿
		pi.setStartRowIndex(); // �쁽�옱 �럹�씠吏��뿉�꽌 蹂댁뿬二쇨린 �떆�옉�븷 湲��쓽 index踰덊샇

		// �럹�씠吏� 釉붾윮
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		return pi;
	}

	private PagingInfo makePagingInfo(adminPagingInfoDTO dto, Map<String, Object> map) throws Exception {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(oDAO.getSearchTotalPostCnt(map));

		pi.setTotalPageCnt(); // �쟾泥� �럹�씠吏� �닔 �꽭�똿
		pi.setStartRowIndex(); // �쁽�옱 �럹�씠吏��뿉�꽌 蹂댁뿬二쇨린 �떆�옉�븷 湲��쓽 index踰덊샇

		// �럹�씠吏� 釉붾윮
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		return pi;
	}

	@Override
	public Map<String, Object> getSearchFilter(CancelSearchDTO search, adminPagingInfoDTO dto) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<AdminCancleVO> li = new ArrayList<AdminCancleVO>();
		resultMap.put("cancel_type", search.getCancel_type());
		resultMap.put("cancel_status", search.getCancel_status());
		resultMap.put("cancel_apply_date_start", search.getCancel_apply_date_start());
		resultMap.put("cancel_apply_date_end", search.getCancel_apply_date_end());
		PagingInfo pagingInfo = makePagingInfo(dto, resultMap);
		System.out.println(pagingInfo.getStartRowIndex());
		System.out.println(pagingInfo.getViewPostCntPerPage());
		resultMap.put("startRowIndex", pagingInfo.getStartRowIndex());
		resultMap.put("viewPostCntPerPage", pagingInfo.getViewPostCntPerPage());
		li = oDAO.getSearchFilter(resultMap);
		System.out.println(li.toString());
		returnMap.put("CancelList", li);
		returnMap.put("PagingInfo", pagingInfo);

		return returnMap;
	}

	@Override
	public AdminPaymentVO getPaymentModuleKeyByOrderId(AdminGetCancel cancelDto) {
		List<Integer> list = cancelDto.getList();
		return oDAO.getPaymentModuleKeyByOrderId(list);
	}

	@Override
	public List<AdminCancleVO> getListByOrderId(String orderId) {

		return oDAO.getListByOrderId(orderId);
	}

	@Override
	public int RestractByCancelNo(String cancelNo) {
		return oDAO.RestractByCancelNo(cancelNo);
	}

	@Override
	@Transactional(isolation = Isolation.DEFAULT, rollbackFor = Exception.class)
	public boolean modifyCancelStatus(ModifyCancelStatusDTO modifyCancelStatusDTO) {
		System.out.println(modifyCancelStatusDTO.toString());

		int cancelUpdateResult = 0;
		String orderId = "";
		String cancelNoList = "";
		Map<String, Object> map = new HashMap<String, Object>();
		List<Integer> cancelList = new ArrayList<Integer>();
		for (int i = 0; i < modifyCancelStatusDTO.getCancelList().size(); i++) {
			cancelList.add(Integer.valueOf(modifyCancelStatusDTO.getCancelList().get(i)));
		}
		log.info("취소 날짜 완료로 변경");
		if (cancelList.size() >= 1) {
			try {
				cancelUpdateResult = oDAO.updateCancelCompleteDate(cancelList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("Updated rows count: " + cancelUpdateResult);
		cancelNoList = String.join(",", modifyCancelStatusDTO.getCancelList());
		System.out.println("Cancel No List: " + cancelNoList);
		try {
			if (cancelUpdateResult >= 1) {
				map.put("paymentNo", modifyCancelStatusDTO.getPaymentNo());
				map.put("cancelType", modifyCancelStatusDTO.getCancelType());
				map.put("cancelNo", cancelNoList);
				map.put("amount", modifyCancelStatusDTO.getAmount());
				log.info("환불 테이블 데이터 삽입 변경");
				oDAO.insertRefund(map);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		log.info("캔슬번호로 오더아이디 구해오기");

		orderId = oDAO.getOrderIdByCancelNo(cancelList);
		AdminPayOrdererVO expectResult = oDAO.getExpectPayAmount(orderId);
		log.info("비회원이 아닐경우 멤버 테이블에서 멤버아이디를 가져온다");
		String findMemberId = oDAO.findMemberId(orderId);
		log.info("가져오기 성공");
		log.info(orderId);
		log.info(findMemberId);
		try {
			if (findMemberId != null && findMemberId != "") {
				log.info("돌려줘야할 포인트가 0이 아닐시");
				if (modifyCancelStatusDTO.getAssigned_point() != 0) {

					log.info("" + expectResult.getTotal_price_expected());
					log.info("" + modifyCancelStatusDTO.getAmount());
					log.info("포인트 적립 내역에 사용한 포인트 넣기");
					log.info("" + modifyCancelStatusDTO.getAssigned_point());
					int result = oDAO.refundPoint((modifyCancelStatusDTO.getAssigned_point()),
							expectResult.getOrderer_id());
					log.info(expectResult.getOrderer_id());
					if (result >= 1) {
						log.info("멤버에게 포인트 돌려주기");
						oDAO.returnMemberPoint(modifyCancelStatusDTO.getAssigned_point(), expectResult.getOrderer_id());

					} else {
						throw new RuntimeException("포인트 반환 실패");
					}
					if (modifyCancelStatusDTO.getAmount() != 0) {
						log.info("해당하는 회원의 level_point 를 가져오기");
						float levelPoint = oDAO.memberLevelPoint(findMemberId);
						log.info("" + levelPoint);
						int stealPoint = (int) (modifyCancelStatusDTO.getAmount() * levelPoint);
						log.info("" + stealPoint);
						int minusStealPoint = stealPoint * -1;
						log.info("포인트 적립내역 테이블에 데이터 삽입하기");
						if (oDAO.restractPoint(findMemberId, minusStealPoint) >= 1) {
							log.info("유저에게 포인트 빼앗기");
							oDAO.restractPointMember(findMemberId, stealPoint);
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		log.info("전체취소 if 문 시작");
		try {
			if ((expectResult.getTotal_price_expected() - 2500) == modifyCancelStatusDTO.getAmount()) {
				log.info("쿠폰 사용 내역 삭제하기");
				if (expectResult.getCoupon_no() <= 0) {
					oDAO.deleteUseCoupon(expectResult.getCoupon_no());
				}

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return true;
	}

	@Override
	public Map<String, Object> getAllrefund(adminPagingInfoDTO dto) throws Exception {

		// TODO Auto-generated method stub
		PagingInfo pagingInfo = makePagingInfo2(dto);
		List<AdminCancleVO> list;

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Integer> pageMap = new HashMap<String, Integer>();
		pageMap.put("startRowIndex", pagingInfo.getStartRowIndex());
		pageMap.put("viewPostCntPerPage", pagingInfo.getViewPostCntPerPage());
		try {
			list = oDAO.getAllRefund(pageMap);

			resultMap.put("refundList", list);
			resultMap.put("PagingInfo", pagingInfo);

			return resultMap;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return resultMap;

	}

	private PagingInfo makePagingInfo2(adminPagingInfoDTO dto) throws Exception {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(oDAO.getTotalRefund());

		pi.setTotalPageCnt(); // �쟾泥� �럹�씠吏� �닔 �꽭�똿
		pi.setStartRowIndex(); // �쁽�옱 �럹�씠吏��뿉�꽌 蹂댁뿬二쇨린 �떆�옉�븷 湲��쓽 index踰덊샇

		// �럹�씠吏� 釉붾윮
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		return pi;
	}

	@Override
	public Map<String, Object> getSearchRefundFilter(AdminSearchRefundDTO searchDto, adminPagingInfoDTO pagingDto) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<AdminCancleVO> li = new ArrayList<AdminCancleVO>();
		resultMap.put("refund_type", searchDto.getRefund_type());
		resultMap.put("refund_start_date", searchDto.getRefund_start_date());
		resultMap.put("refund_end_date", searchDto.getRefund_end_date());

		PagingInfo pagingInfo = makePagingInfo2(pagingDto, resultMap);
		resultMap.put("startRowIndex", pagingInfo.getStartRowIndex());
		resultMap.put("viewPostCntPerPage", pagingInfo.getViewPostCntPerPage());
		li = oDAO.getSearchRefundFilter(resultMap);
		System.out.println(li.toString());
		returnMap.put("refundList", li);
		returnMap.put("PagingInfo", pagingInfo);

		return returnMap;
	}

	private PagingInfo makePagingInfo2(adminPagingInfoDTO pagingDto, Map<String, Object> resultMap) {
		PagingInfo pi = new PagingInfo(pagingDto);
		pi.setTotalPostCnt(oDAO.getSearchRefundTotalPostCnt(resultMap));

		pi.setTotalPageCnt(); // �쟾泥� �럹�씠吏� �닔 �꽭�똿
		pi.setStartRowIndex(); // �쁽�옱 �럹�씠吏��뿉�꽌 蹂댁뿬二쇨린 �떆�옉�븷 湲��쓽 index踰덊샇

		// �럹�씠吏� 釉붾윮
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		return pi;
	}

}
