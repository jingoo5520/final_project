package com.finalProject.service.admin;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.GenderCountDTO;
import com.finalProject.model.admin.LevelCountDTO;
import com.finalProject.persistence.admin.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	AdminDAO aDao;
	
	@Override
	public Map<String, Object> getStatisticData() throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();
		
		// 멤버 총 수
		int memberCnt = aDao.selectAllMemberCnt();
		
		// 지난 달 멤버 가입 수
		int lastMonthMemberRegCnt  = aDao.selectLastMonthMemberRegCnt();
		
		// 지난 달 대비 증가율
		float memberGrowthRate = ((float) lastMonthMemberRegCnt / memberCnt) * 100; 

		// 멤버 성별 회원 수 가져오기
		List<GenderCountDTO> genderCountDTOList = aDao.selectMembersByGender();
		List<LevelCountDTO> levelCountDTOList = aDao.selectMembersByLevel();
		
		data.put("memberCnt", memberCnt);
		data.put("memberGrowthRate", memberGrowthRate);
		data.put("genderList", genderCountDTOList);
		data.put("levelList", levelCountDTOList);
		
		System.out.println(levelCountDTOList);
		
		return data;
	}

	@Override
	public int getMemberRegCnt(Timestamp regDate_start, Timestamp regDate_end) throws Exception {
		return aDao.selectMemberRegCnt(regDate_start, regDate_end);
	}

}
