package com.finalProject.persistence.admin.order;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.order.AdminCancleVO;
import com.finalProject.model.admin.order.AdminPayOrdererVO;
import com.finalProject.model.admin.order.AdminPaymentVO;
import com.finalProject.model.admin.order.ModifyCancelStatusDTO;

public interface OrdersDAO {

	List<AdminCancleVO> getAllCancle(Map<String, Integer> pageMap);

	int getSearchTotalPostCnt(Map<String, Object> map);

	List<AdminCancleVO> getTopCancle();

	List<AdminCancleVO> getSearchFilter(Map<String, Object> resultMap);

	int getTotalPostCnt();

	AdminPaymentVO getPaymentModuleKeyByOrderId(List<Integer> list);

	List<AdminCancleVO> getListByOrderId(String orderId);

	int RestractByCancelNo(String cancelNo);

	int updateCancelCompleteDate(List<Integer> cancelList);

	int insertRefund(ModifyCancelStatusDTO modifyCancelStatusDTO);

	String getOrderIdByCancelNo(List<Integer> cancelList);

	AdminPayOrdererVO getExpectPayAmount(String orderId);

	int returnPoint(int assigned_point, String orderer_id);

	void returnMemberPoint(int assigned_point, String orderer_id);

}
