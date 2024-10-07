package com.finalProject.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.finalProject.model.Member;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
public class SettingTestController {
	
	@Test
	public void lombokTest() {
		Member member = new Member("tester");
		
		System.out.println(member.getMember_id());
		System.out.println(member);
	}
}
