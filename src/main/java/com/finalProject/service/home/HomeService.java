package com.finalProject.service.home;

import java.util.Map;

public interface HomeService {
	
	// 홈페이지 데이터 가져오기
	Map<String, Object> getHomeData() throws Exception;
}
