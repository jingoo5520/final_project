package com.finalProject.service.admin.orders;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.order.AdminCancleVO;
import com.finalProject.model.admin.order.AdminGetCancel;
import com.finalProject.model.admin.order.AdminPaymentVO;
import com.finalProject.model.admin.order.AdminSearchRefundDTO;
import com.finalProject.model.admin.order.CancelSearchDTO;
import com.finalProject.model.admin.order.ModifyCancelStatusDTO;
import com.finalProject.model.admin.product.adminPagingInfoDTO;

public interface OrdersService {

	Map<String, Object> getAllCancle(adminPagingInfoDTO dto) throws Exception;

	Map<String, Object> getSearchFilter(CancelSearchDTO search, adminPagingInfoDTO dto) throws Exception;

	AdminPaymentVO getPaymentModuleKeyByOrderId(AdminGetCancel cancelDto);

	List<AdminCancleVO> getListByOrderId(String orderId);

	int RestractByCancelNo(String cancelNo);

	boolean modifyCancelStatus(ModifyCancelStatusDTO modifyCancelStatusDTO);

	Map<String, Object> getAllrefund(adminPagingInfoDTO dto) throws Exception;

	Map<String, Object> getSearchRefundFilter(AdminSearchRefundDTO searchDto, adminPagingInfoDTO pagingDto);

}
