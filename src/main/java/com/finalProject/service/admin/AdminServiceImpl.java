package com.finalProject.service.admin;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.CancelCountDTO;
import com.finalProject.model.admin.CancelRevenueDTO;
import com.finalProject.model.admin.GenderCountDTO;
import com.finalProject.model.admin.LevelCountDTO;
import com.finalProject.model.admin.RevenueDTO;
import com.finalProject.model.admin.SaleCountDTO;
import com.finalProject.persistence.admin.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	AdminDAO aDao;

	@Override
	public Map<String, Object> getStatisticData() throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();
		List<Integer> list = new ArrayList<>();
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1); // 하루 전 날짜로 설정
		Timestamp yesterday = new Timestamp(calendar.getTimeInMillis());

		// 금일 가입자 수
		int todayRegMemberCnt = aDao.selectMemberRegCnt(now);
		int yesterdayRegMemberCnt = aDao.selectMemberRegCnt(yesterday);
		float regGrowthRate;

		if (yesterdayRegMemberCnt == 0) {
			regGrowthRate = 0;
		} else {
			regGrowthRate = ((float) (todayRegMemberCnt - yesterdayRegMemberCnt) / yesterdayRegMemberCnt) * 100;
		}

		// 처리되지 않은 문의 수
		int waitInquiryCnt = aDao.selectWaitInquiryCnt();

		// 특정 날 판매 량
		int daySaleCnt = aDao.selectDaySaleCnt(now);
		int yesterDaySaleCnt = aDao.selectDaySaleCnt(yesterday);
		float saleGrowthRate;

		if (yesterDaySaleCnt == 0) {
			saleGrowthRate = 0;
		} else {
			saleGrowthRate = ((float) (daySaleCnt - yesterDaySaleCnt) / yesterDaySaleCnt) * 100;
		}

		// 특정 날 판매 금액
		int dayRevenue = aDao.selectDayRevenue(now);
		int yesterDayRevenue = aDao.selectDayRevenue(yesterday);
		float revenueGrowthRate;

		if (yesterDayRevenue == 0) {
			revenueGrowthRate = 0;
		} else {
			revenueGrowthRate = ((float) (dayRevenue - yesterDayRevenue) / yesterDayRevenue) * 100;
		}

		// 멤버 총 수
		int memberCnt = aDao.selectAllMemberCnt();

		// 지난 달 멤버 가입 수
		int lastMonthMemberRegCnt = aDao.selectLastMonthMemberRegCnt();

		// 지난 달 대비 증가율
		float memberGrowthRate;
		if (lastMonthMemberRegCnt == 0) {
			memberGrowthRate = 0;
		} else {
			memberGrowthRate = ((float) lastMonthMemberRegCnt / memberCnt) * 100;
		}

		// 멤버 성별 회원 수 가져오기
		List<GenderCountDTO> genderCountDTOList = aDao.selectMembersByGender();
		List<LevelCountDTO> levelCountDTOList = aDao.selectMembersByLevel();

		// 카테고리별 판매량 가져오기
		List<SaleCountDTO> saleCountDTOList = aDao.selectTotalSales();
		List<String> cancelNos = aDao.refundsCancel();
		list = cancelNos.stream().flatMap(cancel -> Arrays.stream(cancel.split(","))).map(Integer::valueOf)
				.collect(Collectors.toList());
		// 카테고리별 취소량 가져오기
		List<CancelCountDTO> cancelCountDToList = aDao.selectTotalByMonth(list);
		// 카테고리별 매출 가져오기
		List<RevenueDTO> revenueDTOList = aDao.selectTotalRevenues();
		// 카테고리별 취소 매출 가져오기
		List<CancelRevenueDTO> cancelRevenueDTOList = aDao.selectTotalCancelRevenues(list);

		// 취소 대기 수 가져오기
		int cancelReplyCount = aDao.getCancelCnt();
		// 반품 대기 수 가져오기
		int refundReplyCount = aDao.getRefundCnt();

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
		data.put("saleCountDTOList", saleCountDTOList);
		data.put("cancelCountDToList", cancelCountDToList);
		data.put("revenueDTOList", revenueDTOList);
		data.put("cancelRevenueDTOList", cancelRevenueDTOList);
		data.put("cancelReplyCount", cancelReplyCount);
		data.put("refundReplyCount", refundReplyCount);

		return data;
	}

	@Override
	public int selectRangedMemberRegCnt(Timestamp regDate_start, Timestamp regDate_end) throws Exception {
		return aDao.selectRangedMemberRegCnt(regDate_start, regDate_end);
	}

	@Override
	public List<SaleCountDTO> getSalesByMonth(String selectedMonth) throws Exception {
		if (selectedMonth.equals("")) {
			return aDao.selectTotalSales();
		}
		return aDao.selectSalesByMonth(selectedMonth);
	}

	@Override
	public List<RevenueDTO> getRevenuesByMonth(String selectedMonth) throws Exception {
		if (selectedMonth.equals("")) {
			return aDao.selectTotalRevenues();
		}
		return aDao.selectRevenuesByMonth(selectedMonth);
	}

	@Override
	public List<CancelCountDTO> getCancelByMonth(String selectedMonth) throws Exception {
		List<Integer> list = new ArrayList<>();

		List<CancelCountDTO> nullList = new ArrayList<>();
		if (!selectedMonth.equals("") && !selectedMonth.equals(null)) {
			List<String> cancelNos = aDao.CategoryCancelByDate(selectedMonth);
			System.out.println(cancelNos);
			list = cancelNos.stream().flatMap(cancel -> Arrays.stream(cancel.split(","))).map(Integer::valueOf)
					.collect(Collectors.toList());
			if (list.size() <= 0) {
				return nullList;
			}
		}

		if (selectedMonth.equals("")) {

			List<String> cancelNos = aDao.refundsCancel();
			list = cancelNos.stream().flatMap(cancel -> Arrays.stream(cancel.split(","))).map(Integer::valueOf)
					.collect(Collectors.toList());
			// 카테고리별 취소량 가져오기
			return aDao.selectTotalByMonth(list);
		}
		return aDao.selectTotalByMonth(list);
	}

	@Override
	public List<CancelRevenueDTO> getRevenueCancelByMonth(String selectedMonth) throws Exception {
		List<CancelRevenueDTO> nullList = new ArrayList<>();
		List<Integer> list = new ArrayList<>();
		if (!selectedMonth.equals("") && !selectedMonth.equals(null)) {
			List<String> cancelNos = aDao.CategoryCancelByDate(selectedMonth);
			list = cancelNos.stream().flatMap(cancel -> Arrays.stream(cancel.split(","))).map(Integer::valueOf)
					.collect(Collectors.toList());
			if (list.size() <= 0) {
				return nullList;
			}
		}
		if (selectedMonth.equals("")) {

			List<String> cancelNos = aDao.refundsCancel();
			list = cancelNos.stream().flatMap(cancel -> Arrays.stream(cancel.split(","))).map(Integer::valueOf)
					.collect(Collectors.toList());
			// 카테고리별 취소가격 가져오기
			return aDao.selectTotalCancelRevenues(list);
		}
		return aDao.selectTotalCancelRevenues(list);
	}

}
