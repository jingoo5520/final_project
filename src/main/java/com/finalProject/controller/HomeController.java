package com.finalProject.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.finalProject.service.home.HomeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {

	@Inject
	HomeService hService;
	
	
	@GetMapping("/")
	public String homePage(Model model) {
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		try {
			data = hService.getHomeData();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(data);
		
		model.addAttribute("newProducts", data.get("newProducts"));
		return "/user/index";
	}
	

}
