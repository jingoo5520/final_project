package com.finalProject.controller.admin.black;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.black.BlackMemberDTO;
import com.finalProject.model.admin.product.adminPagingInfoDTO;
import com.finalProject.service.admin.black.BlackService;

@Controller
@RequestMapping("/admin/memberView")
public class MemberBlackController {

	@Autowired
	private BlackService bs;

	@RequestMapping("")
	public String Home(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "pagingSize", defaultValue = "10") int PagingSize) {
		adminPagingInfoDTO dto = adminPagingInfoDTO.builder().pageNo(pageNo).pagingSize(PagingSize).build();
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

		System.out.println(bm.getBlack());
		try {
			map = bs.getSearchMember(bm);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(map.get("MemberList"));
		System.out.println(map.get("PagingInfo"));
		return map;

	}

	@RequestMapping(value = "/blackMembers", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> blackMember(@RequestBody Map<String, List<String>> map) {
		try {
			if (bs.blackMember(map)) {
				return new ResponseEntity<String>("Success", HttpStatus.OK);
			} else {
				return new ResponseEntity<String>("faule", HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<String>("faule", HttpStatus.BAD_REQUEST);
		}

	}

	@RequestMapping(value = "/cancelBlack", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> blackCancelMember(@RequestBody Map<String, Object> memberJsonId) {
		String memberId = (String) memberJsonId.get("member_id");
		try {
			if (bs.blackCancelMember(memberId)) {
				return new ResponseEntity<String>("Success", HttpStatus.OK);
			} else {
				return new ResponseEntity<String>("faule", HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
	}
}
