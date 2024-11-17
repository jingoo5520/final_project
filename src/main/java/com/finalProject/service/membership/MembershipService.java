package com.finalProject.service.membership;

import java.util.List;

import com.finalProject.model.level.LevelDTO;

public interface MembershipService {

	// 등급 정보 가져오기
	List<LevelDTO> getLevelInfos() throws Exception;

}
