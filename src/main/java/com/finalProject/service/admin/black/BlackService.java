package com.finalProject.service.admin.black;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.black.BlackMemberDTO;
import com.finalProject.model.admin.product.adminPagingInfoDTO;

public interface BlackService {
	Map<String, Object> getAllMember(adminPagingInfoDTO dto) throws Exception;

	Map<String, Object> getSearchMember(BlackMemberDTO bm) throws Exception;

	boolean blackMember(Map<String, List<String>> map) throws Exception;

	boolean blackCancelMember(String memberId);

}
