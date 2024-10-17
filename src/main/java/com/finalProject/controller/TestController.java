package com.finalProject.controller;

import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

import com.finalProject.model.TestVO;
import com.finalProject.service.TestService;

@Controller
@RequestMapping(value="/test")
public class TestController {

	@Inject
	private TestService service;

	@RequestMapping(value = "/uuid")
	public String uuid() {
		UUID randomuuid = UUID.randomUUID();
		System.out.println(randomuuid.toString().substring(0, 8));
		return "/testIndex";
	}

}
