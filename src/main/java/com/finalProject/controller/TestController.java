package com.finalProject.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.finalProject.model.TestVO;
import com.finalProject.service.TestService;

@RestController
@RequestMapping("/test")
public class TestController {
	
	@Inject
	private TestService service;
	
	@GetMapping("/startTest")
	public List<TestVO> startTest() {
		System.out.println("sys test");
		List<TestVO> list = null;
		
		
		try {
			list = service.getTestData();
			System.out.println(list);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
}
