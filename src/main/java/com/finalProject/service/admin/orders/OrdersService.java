package com.finalProject.service.admin.orders;

import java.util.Map;

import com.finalProject.model.admin.order.AdminPaymentVO;
import com.finalProject.model.admin.order.CancelSearchDTO;
import com.finalProject.model.admin.product.adminPagingInfoDTO;

public interface OrdersService {

	Map<String, Object> getAllCancle(adminPagingInfoDTO dto) throws Exception;

	Map<String, Object> getSearchFilter(CancelSearchDTO search, adminPagingInfoDTO dto) throws Exception;

	AdminPaymentVO getPaymentModuleKeyByOrderId(int cancelNo);

}
