package com.finalProject.persistence.admin;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.CancelCountDTO;
import com.finalProject.model.admin.CancelRevenueDTO;
import com.finalProject.model.admin.GenderCountDTO;
import com.finalProject.model.admin.LevelCountDTO;
import com.finalProject.model.admin.RevenueDTO;
import com.finalProject.model.admin.SaleCountDTO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.adminMapper.";

	@Override
	public int selectAllMemberCnt() throws Exception {
		return ses.selectOne(ns + "selectAllMemberCnt");
	}

	@Override
	public int selectLastMonthMemberRegCnt() throws Exception {
		return ses.selectOne(ns + "selectLastMonthMemberRegCnt");
	}

	@Override
	public List<GenderCountDTO> selectMembersByGender() throws Exception {
		return ses.selectList(ns + "selectMembersByGender");
	}

	@Override
	public List<LevelCountDTO> selectMembersByLevel() throws Exception {
		System.out.println(ses.selectList(ns + "selectMembersByLevel"));

		return ses.selectList(ns + "selectMembersByLevel");
	}

	@Override
	public int selectMemberRegCnt(Timestamp time) throws Exception {
		return ses.selectOne(ns + "selectMemberRegCnt", time);
	}

	@Override
	public int selectWaitInquiryCnt() throws Exception {
		return ses.selectOne(ns + "selectWaitInquiryCnt");
	}

	@Override
	public int selectDaySaleCnt(Timestamp time) throws Exception {

		return ses.selectOne(ns + "selectDaySaleCnt", time);
	}

	@Override
	public int selectDayRevenue(Timestamp time) throws Exception {
		return ses.selectOne(ns + "selectDayRevenue", time);
	}

	@Override
	public int selectRangedMemberRegCnt(Timestamp regDate_start, Timestamp regDate_end) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();

		params.put("regDate_start", regDate_start);
		params.put("regDate_end", regDate_end);

		return ses.selectOne(ns + "selectRangedMemberRegCnt", params);
	}

	@Override
	public List<SaleCountDTO> selectTotalSales() throws Exception {
		return ses.selectList(ns + "selectTotalSales");
	}

	@Override
	public List<SaleCountDTO> selectSalesByMonth(String selectedMonth) throws Exception {
		return ses.selectList(ns + "selectSalesByMonth", selectedMonth);
	}

	@Override
	public List<RevenueDTO> selectTotalRevenues() throws Exception {
		return ses.selectList(ns + "selectTotalRevenues");
	}

	@Override
	public List<RevenueDTO> selectRevenuesByMonth(String selectedMonth) throws Exception {
		return ses.selectList(ns + "selectRevenuesByMonth", selectedMonth);
	}

	// 추가
	@Override
	public List<CancelCountDTO> selectTotalCancel() {
		// TODO Auto-generated method stub
		return ses.selectList(ns + "selectCancelByMonth");
	}

	// 추가
	@Override
	public List<CancelCountDTO> selectTotalByMonth(List<Integer> list) {
		// TODO Auto-generated method stub
		return ses.selectList(ns + "selectCancelSales", list);
	}

	@Override
	public List<String> CategoryCancelByDate(String selectedMonth) {

		return ses.selectList(ns + "CategoryCancelByDateCnt", selectedMonth);
	}

	@Override
	public List<CancelCountDTO> selectTotalCancelCnt() {
		// TODO Auto-generated method stub
		return ses.selectList(ns);
	}

	@Override
	public List<String> refundsCancel() {
		// TODO Auto-generated method stub
		return ses.selectList(ns + "refundsCancel");
	}

	@Override
	public List<CancelRevenueDTO> selectTotalCancelRevenues(List<Integer> list) {

		return ses.selectList(ns + "selectTotalCancelRevenues", list);
	}

	@Override
	public int getCancelCnt() {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getCancelCnt");
	}

	@Override
	public int getRefundCnt() {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getRefundCnt");
	}

}
