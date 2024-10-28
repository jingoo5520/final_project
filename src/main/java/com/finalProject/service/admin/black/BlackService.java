package com.finalProject.service.admin.black;

import java.util.Map;

import com.finalProject.model.admin.black.BlackMemberDTO;
import com.finalProject.model.admin.product.ProductPagingInfoDTO;

public interface BlackService {
	Map<String, Object> getAllMember(ProductPagingInfoDTO dto) throws Exception;

	Map<String, Object> getSearchMember(BlackMemberDTO bm);
}
