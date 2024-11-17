package com.finalProject.controller.admin.notices;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.service.admin.notices.BannerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/notices/banner")
public class BannerController {
	
	/*
	 * @Autowired private BannerService bannerService;
	 * 
	 * @GetMapping("/select") public String selectBannerPage(Model model) {
	 * model.addAttribute("banners", bannerService.getAvailableBanners()); return
	 * "selectBanner"; }
	 * 
	 * @PostMapping("/upload") public String
	 * uploadBanner(@RequestParam("bannerImage") MultipartFile file) {
	 * bannerService.uploadBanner(file); return "redirect:/admin/banner/select"; }
	 * 
	 * @PostMapping("/selectBanner") public String
	 * selectBanner(@RequestParam("selectedBanner") String fileName) {
	 * bannerService.setSelectedBanner(fileName); return
	 * "redirect:/admin/banner/select"; }
	 */
}
