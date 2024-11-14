package com.finalProject.persistence.admin.order;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.order.AdminCancleVO;
import com.finalProject.model.admin.order.AdminPayOrdererVO;
import com.finalProject.model.admin.order.AdminPaymentVO;

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

	int insertRefund(Map<String, Object> map);

	String getOrderIdByCancelNo(List<Integer> cancelList);

	AdminPayOrdererVO getExpectPayAmount(String orderId);

	int refundPoint(int assigned_point, String orderer_id);

	void returnMemberPoint(int assigned_point, String orderer_id);

	int refundEarnedPoint(int use_point, String orderer_id);

	void deleteUseCoupon(int coupon_no);

	void refundMemberUsePoint(int use_point, String orderer_id);

	float memberLevelPoint(String orderId);

	int restractPoint(String orderId, int stealPoint);

	void restractPointMember(String orderId, int stealPoint);

	String findMemberId(String orderId);

}
