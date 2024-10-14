package com.finalProject.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.TestVO;

@Repository
public class TestDAO {
	
	@Inject
	private SqlSession ses;
	
	private static final String ns = "com.finalProject.mappers.testMapper.";
	
		public List<TestVO> getTestData() throws Exception {
			System.out.println("dao sys getTestData()...");
			
			return ses.selectList(ns + "getTestData");
		}
}
