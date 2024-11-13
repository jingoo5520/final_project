package com.finalProject.service.admin;

import java.sql.Timestamp;
import java.util.Map;

public interface AdminService {

	// 통계 데이터 가져오기
	Map<String, Object> getStatisticData() throws Exception;

	// 기간에 따른 가입자 수 가져오기
	int selectRangedMemberRegCnt(Timestamp regDate_start, Timestamp regDate_end) throws Exception;
	

}
