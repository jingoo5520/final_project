package com.finalProject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.finalProject.model.admin.homepage.BannerDTO;
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
		List<BannerDTO> mainBannerList = new ArrayList<BannerDTO>();
		List<BannerDTO> subBannerList = new ArrayList<BannerDTO>();
		
		
		try {
			data = hService.getHomeData();
			
			List<BannerDTO> bannerList = (List<BannerDTO>) data.get("bannerList");
			
			System.out.println(bannerList);
			
			for(BannerDTO banner : bannerList) {
				if (banner.getBanner_type().equals("M")) {
			        mainBannerList.add(banner);
			    } else {
			        subBannerList.add(banner);
			    }
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(data);
		
		
		
		model.addAttribute("newProducts", data.get("newProducts"));
		model.addAttribute("mainBannerList", mainBannerList);
		model.addAttribute("subBannerList", subBannerList);
		
		return "/user/index";
	}
	

}
