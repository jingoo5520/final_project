package com.finalProject.persistence.membership;

import java.util.List;

import javax.inject.Inject;
import javax.swing.event.ListSelectionListener;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.level.LevelDTO;

@Repository
public class MembershipDAOImpl implements MembershipDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.levelMapper.";
	
	
	@Override
	public List<LevelDTO> selectLevelInfos() throws Exception {
		
		return ses.selectList(ns + "selectLevelInfos");
	}

}
