package com.finalProject.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class PointDAOImpl implements PointDAO {

	@Inject
	SqlSession ses;

	private String ns = "com.finalProject.mappers.pointMapper.";
	
	// 포인트 지급 기록
	@Override
	public void insertPointPlus(String member_id, int point_code) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("point_code", point_code);
		ses.insert(ns+"insertPointPlus", map);
	}

	// 포인트 사용 기록
	@Override
	public void insertPointminus(String member_id, int use_point) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("use_point", use_point);
		ses.insert(ns+"insertPointminus", map);
	}

	// 포인트 추가, 사용  (point를 음수로 입력하면 사용, 양수로 입력하면 추가)
	@Override
	public int updatePoint(String member_id, int point) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("point", point);
		return ses.insert(ns+"updatePoint", map);
	}

}
