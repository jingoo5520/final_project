package com.finalProject.controller.admin.black;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.black.BlackMemberDTO;
import com.finalProject.model.admin.product.ProductPagingInfoDTO;
import com.finalProject.service.admin.black.BlackService;

@Controller
@RequestMapping("/admin/memberView")
public class MemberBlackController {

	@Autowired
	private BlackService bs;

	@RequestMapping("")
	public String Home(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "pagingSize", defaultValue = "10") int PagingSize) {
		ProductPagingInfoDTO dto = ProductPagingInfoDTO.builder().pageNo(pageNo).pagingSize(PagingSize).build();
		try {
			model.addAttribute("memberList", bs.getAllMember(dto).get("MemberList"));
			model.addAttribute("PagingInfo", bs.getAllMember(dto).get("PagingInfo"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "admin/pages/blackmanage/adminmemberview";
	}

	@RequestMapping("/searchMembers")
	@ResponseBody
	public Map<String, Object> SearchMember(@RequestBody BlackMemberDTO bm) {
		Map<String, Object> map = new HashMap<String, Object>();

		map = bs.getSearchMember(bm);
		System.out.println(map.get("MemberList"));

		return map;

	}
}
