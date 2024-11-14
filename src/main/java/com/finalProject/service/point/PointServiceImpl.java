package com.finalProject.service.point;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.persistence.PointDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PointServiceImpl implements PointService{

	@Inject
	private PointDAO pDAO;
	
	// 포인트 지급 기록
	@Override
	public void insertPointPlus(String member_id, int point_code) throws Exception {
		pDAO.insertPointPlus(member_id, point_code);
	}

	// 포인트 사용 기록
	@Override
	public void insertPointminus(String member_id, int use_point) throws Exception {
		pDAO.insertPointminus(member_id, use_point);
	}

	// 포인트 추가, 사용  (point를 음수로 입력하면 사용, 양수로 입력하면 추가)
	@Override
	public int updatePoint(String member_id, int point) throws Exception {
		return pDAO.updatePoint(member_id, point);
	}

}
