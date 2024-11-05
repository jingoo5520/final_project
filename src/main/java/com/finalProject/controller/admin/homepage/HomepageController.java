package com.finalProject.controller.admin.homepage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/homepage")
public class HomepageController {

	@GetMapping("/banners")
	public String bannerPage(Model model) {
		// 이동시 쿠폰 리스트를 가져오며
		/*
		 * Map<String, Object> data = new HashMap<String, Object>(); List<CouponDTO>
		 * list = null;
		 * 
		 * try { data = cService.getCouponList(new PagingInfoNewDTO(1, 5, 3)); } catch
		 * (Exception e) { e.printStackTrace(); }
		 * 
		 * System.out.println(data);
		 * 
		 * model.addAttribute("couponData", data);
		 */
		return "/admin/pages/homepage/banners";
	}
	
	
}
