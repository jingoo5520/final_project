package com.finalProject.controller.member;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.finalProject.model.LoginDTO;
import com.finalProject.service.member.MemberService;

@ControllerAdvice
public class MemberControllerAdvice {

	@Inject
	private MemberService memberService;

	@ModelAttribute
	public void showCartItemCount(Model model, HttpSession session, HttpServletRequest request) throws Exception {
		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember"); // 로그인정보 받기
		if (loginDTO != null) { // 로그인 상태 확인
			int wishList[] = memberService.getWishList(loginDTO.getMember_id()); // member_id로 찜목록 조회
			int wishCount = wishList.length;
			model.addAttribute("wishCount", wishCount);
			System.out.println("찜갯수 받음");
		} else {
			model.addAttribute("wishCount", 0);
		}

	}

}
