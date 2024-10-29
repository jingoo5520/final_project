package com.finalProject.service.admin.member;

import java.util.Map;

import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.member.MemberSearchFilterDTO;

public interface AdminMemberService {

	// 회원 목록 조회
	Map<String, Object> getAllMembers(PagingInfoNewDTO pagingInfoDTO) throws Exception;
	
	
	// 회원 목록 조회(필터링)
	Map<String, Object> getFilteredMembers(MemberSearchFilterDTO memberSearchFilterDTO) throws Exception;
	
}
