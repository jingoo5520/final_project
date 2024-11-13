package com.finalProject.service.admin;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Calendar;
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
		
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1); // 하루 전 날짜로 설정
		Timestamp yesterday = new Timestamp(calendar.getTimeInMillis());
		
		// 금일 가입자 수
		int todayRegMemberCnt = aDao.selectMemberRegCnt(now);
		int yesterdayRegMemberCnt = aDao.selectMemberRegCnt(yesterday);
		float regGrowthRate = ((float) (todayRegMemberCnt - yesterdayRegMemberCnt)  / yesterdayRegMemberCnt) * 100; 
		
		// 처리되지 않은 문의 수
		int waitInquiryCnt = aDao.selectWaitInquiryCnt();
		
		// 특정 날 판매 량
		int daySaleCnt = aDao.selectDaySaleCnt(now);
		int yesterDaySaleCnt = aDao.selectDaySaleCnt(yesterday);
		float saleGrowthRate = ((float) (daySaleCnt - yesterDaySaleCnt)  / yesterDaySaleCnt) * 100; 
		
		System.out.println(daySaleCnt);
		System.out.println(yesterDaySaleCnt);
		System.out.println(saleGrowthRate);
		
		// 특정 날 판매 금액
		int dayRevenue = aDao.selectDayRevenue(now);
		int yesterDayRevenue = aDao.selectDayRevenue(yesterday);
		float revenueGrowthRate = ((float) (dayRevenue - yesterDayRevenue)  / yesterDayRevenue) * 100;
		
		// 멤버 총 수
		int memberCnt = aDao.selectAllMemberCnt();
		
		// 지난 달 멤버 가입 수
		int lastMonthMemberRegCnt  = aDao.selectLastMonthMemberRegCnt();
		
		// 지난 달 대비 증가율
		float memberGrowthRate = ((float) lastMonthMemberRegCnt / memberCnt) * 100; 

		// 멤버 성별 회원 수 가져오기
		List<GenderCountDTO> genderCountDTOList = aDao.selectMembersByGender();
		List<LevelCountDTO> levelCountDTOList = aDao.selectMembersByLevel();
		
		// 총 판매량 가져오기
		
		// 총 매출 가져오기
		aDao.getTotalSales();
		
		
		data.put("memberCnt", memberCnt);
		data.put("memberGrowthRate", memberGrowthRate);
		data.put("genderList", genderCountDTOList);
		data.put("levelList", levelCountDTOList);
		data.put("todayRegMemberCnt", todayRegMemberCnt);
		data.put("waitInquiryCnt", waitInquiryCnt);
		data.put("daySaleCnt", daySaleCnt);
		data.put("dayRevenue", dayRevenue);
		data.put("saleGrowthRate", saleGrowthRate);
		data.put("revenueGrowthRate", revenueGrowthRate);
		data.put("regGrowthRate", regGrowthRate);
		
		return data;
	}

	

	@Override
	public int selectRangedMemberRegCnt(Timestamp regDate_start, Timestamp regDate_end) throws Exception {
		return aDao.selectRangedMemberRegCnt(regDate_start, regDate_end);
	}

}
