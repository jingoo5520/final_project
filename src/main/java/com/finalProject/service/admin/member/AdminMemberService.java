package com.finalProject.service.admin.member;

import java.util.Map;

import com.finalProject.model.admin.MemberSearchFilterDTO;
import com.finalProject.model.admin.PagingInfoDTO;

public interface AdminMemberService {

	// 회원 목록 조회
	Map<String, Object> getAllMembers(PagingInfoDTO pagingInfoDTO) throws Exception;
	
	
	// 회원 목록 조회(필터링)
	Map<String, Object> getFilteredMembers(MemberSearchFilterDTO memberSearchFilterDTO) throws Exception;
	
}
