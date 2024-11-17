package com.finalProject.service.membership;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.level.LevelDTO;
import com.finalProject.persistence.membership.MembershipDAO;

@Service
public class MemberShipServiceImpl implements MembershipService {

	@Inject
	MembershipDAO mDao;
	
	@Override
	public List<LevelDTO> getLevelInfos() throws Exception {
		
		List<LevelDTO> list = mDao.selectLevelInfos(); 
		
		return list;
	}

}
