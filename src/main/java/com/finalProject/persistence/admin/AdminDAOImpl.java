package com.finalProject.persistence.admin;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.GenderCountDTO;
import com.finalProject.model.admin.LevelCountDTO;

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
	public int selectMemberRegCnt(Timestamp regDate_start, Timestamp regDate_end) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("regDate_start", regDate_start);
		params.put("regDate_end", regDate_end);
		
		return ses.selectOne(ns + "selectMemberRegCnt", params);
	}

}
