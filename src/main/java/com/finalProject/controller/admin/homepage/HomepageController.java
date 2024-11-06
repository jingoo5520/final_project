package com.finalProject.controller.admin.homepage;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.homepage.BannerDTO;
import com.finalProject.model.admin.homepage.EventDTO;
import com.finalProject.service.admin.homepage.HomepageService;

@Controller
@RequestMapping("/admin/homepage")
public class HomepageController {

	@Inject
	HomepageService hService;
	
	@GetMapping("/banners")
	public String bannerPage(Model model) {
		// 배너 리스트
		Map<String, Object> data = new HashMap<String, Object>();
		List<BannerDTO> mainBannerList = new ArrayList<BannerDTO>();
		List<BannerDTO> subBannerList = new ArrayList<BannerDTO>();
		
		
		try {
			List<BannerDTO> bannerList = hService.getBannerList();
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
		
		model.addAttribute("mainBannerList", mainBannerList);
		model.addAttribute("subBannerList", subBannerList);
		
		return "/admin/pages/homepage/banners";
	}
	
	@GetMapping("/getEventList")
	@ResponseBody
	public List<EventDTO> getEventList() {
		List<EventDTO> list = null;
		
		try {
			list = hService.getEventList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	@GetMapping("/getBannerList")
	@ResponseBody
	public List<BannerDTO> getBannerList() {
		List<BannerDTO> list = null;
		
		try {
			list = hService.getBannerList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@PostMapping("/addBanner")
	public ResponseEntity<String> addBanner(@RequestParam int eventNo, @RequestParam String bannerType) {
		String result = "";
		
		System.out.println(eventNo);
		System.out.println(bannerType);
		
		try {
			hService.addBanner(eventNo, bannerType);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/deleteBanner")
	public ResponseEntity<String> deleteBanner(@RequestParam int bannerNo) {
		String result = "";
		
		try {
			hService.deleteBanner(bannerNo);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	
}
