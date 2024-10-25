package com.finalProject.persistence.admin;

import java.util.List;

import com.finalProject.model.admin.MemberManageDTO;
import com.finalProject.model.admin.MemberSearchFilterDTO;
import com.finalProject.model.admin.PagingInfo;

public interface AdminMemberDAO {

	// 회원 전체 수 조회
	int getTotalMemberCnt() throws Exception;
	
	// 필터링 된 회원 수 조회
	int getTotalFilterdMemberCnt(MemberSearchFilterDTO memberSearchFilterDTO) throws Exception;
	
	// 전체 회원 조회
	List<MemberManageDTO> selectAllMembers(PagingInfo pi) throws Exception;

	// 필터링 회원 조회
	List<MemberManageDTO> selectFilteredMembers(MemberSearchFilterDTO memberSearchFilterDTO, PagingInfo pi) throws Exception;

}
