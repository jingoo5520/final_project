package com.finalProject.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.TestVO;
import com.finalProject.persistence.TestDAO;

@Service
public class TestService {

	@Inject
	private TestDAO tDao;
	
	public List<TestVO> getTestData() throws Exception {
		System.out.println("service sys getTestData()...");
		
		List<TestVO> list = tDao.getTestData();
		
		return list;
	}
	
	
}
