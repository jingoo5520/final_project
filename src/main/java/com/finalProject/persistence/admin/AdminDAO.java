package com.finalProject.persistence.admin;

import java.sql.Timestamp;
import java.util.List;

import com.finalProject.model.admin.GenderCountDTO;
import com.finalProject.model.admin.LevelCountDTO;

public interface AdminDAO {

	// 회원 총 수 가져오기
	int selectAllMemberCnt() throws Exception;

	// 지난 달 회원 총 수 가져오기
	int selectLastMonthMemberRegCnt() throws Exception;

	// 성별 별 회원 수 가져오기
	List<GenderCountDTO> selectMembersByGender() throws Exception;
	
	// 레벨 별 회원 수 가져오기
	List<LevelCountDTO> selectMembersByLevel() throws Exception;

	// 가입 회원 수 가져오기
	int selectMemberRegCnt(Timestamp regDate_start, Timestamp regDate_end) throws Exception;

}
