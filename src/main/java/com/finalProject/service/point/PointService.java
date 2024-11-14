package com.finalProject.service.point;

public interface PointService {

	// 포인트 지급 기록
	void insertPointPlus(String member_id, int point_code)throws Exception;
	
	// 포인트 사용 기록
	void insertPointminus(String member_id, int use_point)throws Exception;
	
	// 포인트 추가, 사용  (point를 음수로 입력하면 사용, 양수로 입력하면 추가)
	int updatePoint(String member_id, int point)throws Exception; 
}
