package com.finalProject.controller.admin.coupon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.management.RuntimeErrorException;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.member.MemberManageDTO;
import com.finalProject.service.admin.coupon.CouponService;
import com.finalProject.service.admin.member.AdminMemberService;

@Controller
@RequestMapping("/admin/coupon")
public class CouponController {

	@Inject
	CouponService cService;

	@Inject
	AdminMemberService amService;

	// 쿠폰 관리 - 쿠폰 페이지 이동
	@GetMapping("/coupons")
	public String couponPage(Model model) {
		// 이동시 쿠폰 리스트를 가져오며
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			data = cService.getCouponList(new PagingInfoNewDTO(1, 5, 3));
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("couponData", data);
		return "/admin/pages/coupon/coupons";
	}

	// 쿠폰 관리 - 쿠폰 지급 내역 페이지 이동
	@GetMapping("/couponPayLogs")
	public String couponUseLogPage() {
		return "/admin/pages/coupon/couponPayLogs";
	}

	// 쿠폰 관리 - 쿠폰 지급 페이지 이동
	@GetMapping("/couponPay")
	public String couponPayPage(Model model) {

		Map<String, Object> data = new HashMap<String, Object>();
		List<MemberManageDTO> list = null;

		try {
			data = amService.getAllMembers(new PagingInfoNewDTO(1, 10, 10));
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("memberData", data);
		return "/admin/pages/coupon/couponPay";
	}

	/* ========================================================================== */
	/* ========================================================================== */

	// 쿠폰 리스트 가져오기
	@GetMapping("/getCouponList")
	@ResponseBody
	public List<CouponDTO> getCouponList() {
		List<CouponDTO> list = null;

		try {
			list = cService.getCouponList();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// 쿠폰 리스트 가져오기(페이지네이션)
	@GetMapping("/getCouponListWithPi")
	@ResponseBody
	public Map<String, Object> getCouponList(@RequestParam int pageNo, @RequestParam int pagingSize,
			@RequestParam int pageCntPerBlock) {

		Map<String, Object> data = new HashMap<String, Object>();

		try {
			data = cService.getCouponList(new PagingInfoNewDTO(pageNo, pagingSize, pageCntPerBlock));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data;
	}

	// 쿠폰 생성
	@PostMapping("/createCoupon")
	@ResponseBody
	public ResponseEntity<String> createCoupon(@RequestBody CouponDTO couponDTO) {
		String result = "";
		try {
			cService.createCoupon(couponDTO);
			result = "success";
		} catch (DuplicateKeyException e) {
			result = "duplicated";
		} catch (Exception e) {
			result = "fail";
			throw new RuntimeErrorException(null, "이름이 중복됬습니다.");
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	// 쿠폰 수정
	@PostMapping("/updateCoupon")
	@ResponseBody
	public ResponseEntity<String> updateCoupon(@RequestBody CouponDTO couponDTO) {
		String result = "";

		System.out.println("/updateCoupon");

		try {
			cService.updateCoupon(couponDTO);
			result = "success";
		} catch (DuplicateKeyException e) {
			result = "duplicated";
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	// 쿠폰 삭제
	@PostMapping("/deleteCoupon")
	@ResponseBody
	public ResponseEntity<String> deleteCoupon(@RequestParam int couponNo) {
		String result = "";

		try {
			cService.deleteCoupon(couponNo);
			result = "success";
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	// 쿠폰 지급
	@PostMapping("/payCoupon")
	public ResponseEntity<String> payCoupon(@RequestBody Map<String, Object> params) {

		List<String> memberIdList = (List<String>) params.get("memberIdList");
		int couponNo = (int) params.get("couponNo");

		String result = "";

		try {
			cService.payCoupon(memberIdList, couponNo);
			result = "success";
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	
	// 쿠폰 지급 로그 리스트 가져오기
	@GetMapping("/getCouponPayLogList")
	@ResponseBody
	public Map<String, Object> getCouponUseLogList(@RequestParam int pageNo, @RequestParam int pagingSize,
			@RequestParam int pageCntPerBlock) {

		Map<String, Object> data = new HashMap<String, Object>();
		
		try {
			data = cService.getCouponPayLogList(new PagingInfoNewDTO(pageNo, pagingSize, pageCntPerBlock));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data;
	}
}
