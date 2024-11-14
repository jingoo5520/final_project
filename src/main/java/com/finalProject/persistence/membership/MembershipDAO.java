package com.finalProject.persistence.membership;

import java.util.List;

import com.finalProject.model.level.LevelDTO;

public interface MembershipDAO {

	// 등급 정보 가져오기
	List<LevelDTO> selectLevelInfos() throws Exception;

}
