package com.finalProject.controller.membership;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.finalProject.model.level.LevelDTO;
import com.finalProject.service.membership.MembershipService;


@Controller
@RequestMapping("/serviceCenter")
public class MembershipController {

	@Inject
	MembershipService mService;
	
	// 멤버십 혜택 페이지 이동
	@GetMapping("/memberships")
	public String membershipPage(Model model) {
		
		List<LevelDTO> list = null;
		
		try {
			list = mService.getLevelInfos();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("levelList", list);
		
		return "/user/pages/membership/memberships";
	}
}
