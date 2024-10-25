package com.finalProject.controller.member;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.ResponseData;
import com.finalProject.model.SignUpDTO;
import com.finalProject.service.MemberService;
import com.finalProject.util.ReceiveMailPOP3;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {

	@Inject
	private MemberService memberService;

	@Inject
	private ReceiveMailPOP3 remail;

	@RequestMapping(value = "/viewLogin") // "/member/viewLogin" 濡쒓렇�씤 �럹�씠吏�濡� �씠�룞
	public String viewLogin() {
		System.out.println("濡쒓렇�씤 �럹�씠吏�濡� �씠�룞");
		return "/user/pages/member/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST) // 濡쒓렇�씤 �슂泥��떆 �룞�옉
	public String login(LoginDTO loginDTO, RedirectAttributes rttr, Model model, HttpSession session, @RequestParam(value="autologin_code", required = false)boolean autologin) {
		System.out.println(loginDTO + "濡� 濡쒓렇�씤 �슂泥�");
		System.out.println("�옄�룞濡쒓렇�씤 : " + autologin);
		log.info("postLogin");
		try {
			LoginDTO loginMember = memberService.login(loginDTO); // �엯�젰�븳 member_id, member_pwd瑜� loginDTO濡� 諛쏆븘�꽌 db�뿉 議고쉶�븳�떎.
			if (loginMember != null) { // �엯�젰�븳 �븘�씠�뵒 鍮꾨�踰덊샇�뿉 �빐�떦�븯�뒗 member媛� �뾾�떎硫� null
				model.addAttribute("loginMember", loginMember); // 紐⑤뜽媛앹껜�뿉 濡쒓렇�씤 �젙蹂� ���옣
				if(autologin) {	// �옄�룞濡쒓렇�씤 泥댄겕�뻽�쓣寃쎌슦
					model.addAttribute("autologin", autologin); // 紐⑤뜽媛앹껜�뿉 �옄�룞濡쒓렇�씤 ���옣
				}
			}

		} catch (Exception e) {

			e.printStackTrace();

		}
		// 濡쒓렇�씤 �꽦怨� �떎�뙣�뿉 �뵲瑜� �럹�씠吏� �씠�룞�� �씤�꽣�뀎�꽣媛� 泥섎━�븿.
		// 由ы꽩 ���엯�쓣 void濡� login.jsp�쓽 form�깭洹� action�뿉 �꽕�젙�맂 寃쎈줈�쓽 jsp瑜� 李얘퀬, �빐�떦 寃쎈줈�쓽 jsp�뒗 �뾾湲곕븣臾몄뿉 �떎�젣�븯�뒗 �븘臾댄뙆�씪�쓽 寃쎈줈瑜� �엫�쓽濡� 由ы꽩�빐以�.
		return "/user/member/login";
	}

	@RequestMapping(value = "/viewSignUp") // "/member/viewSignUp/"
	public String viewSingUp() {
		System.out.println("�쉶�썝媛��엯 �럹�씠吏�濡� �씠�룞");
		return "/user/pages/member/signUp";
	}

	@RequestMapping(value = "/isDuplicate", method = RequestMethod.POST) // �쉶�썝媛��엯 �뜲�씠�꽣 以묐났 泥댄겕 (ajax)
	public ResponseEntity<ResponseData> isDuplicate(@RequestParam("key") String key,
			@RequestParam("value") String value) {
		// key = 以묐났泥댄겕瑜� 吏꾪뻾�븷 �슂�냼(id, email, phone)
		// value = 泥댄겕�븷 媛�
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("key : " + key);
		System.out.println("value : " + value);
		// �쑕���룿踰덊샇媛� 11�옄�씤寃쎌슦(01012345678)
		if(key.equals("phone") && value.length()==11) {
			// 010-1234-5678 濡� 留뚮벀
			value = value.substring(0, 3) + "-" + value.substring(3, 7) + "-" + value.substring(7, 11);
		}
		map.put("key", key);
		map.put("value", value);
		System.out.println(map.toString());

		ResponseData json = null;
		ResponseEntity<ResponseData> result = null;

		try {
			// map�뿉 key�� value瑜� �떞�븘�꽌 荑쇰━臾몄쓣 �떎�뻾
			// key = where�젅�뿉 �뱾�뼱媛� 而щ읆�쓣 寃곗젙
			// value = 李얠쓣 媛�
			if (!memberService.autoDuplicate(map)) {
				json = new ResponseData("notDuplicate", value);
			} else {
				json = new ResponseData("Duplicate", value);
			}
			result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		return result;
	}

	@RequestMapping(value = "/signUp", method = RequestMethod.POST) // �쉶�썝媛��엯 泥섎━
	public String signUp(SignUpDTO signUpDTO, RedirectAttributes rttr) {
		System.out.println("�쉶�썝媛��엯 �슂泥�");
		System.out.println(signUpDTO.toString());
		String result = "redirect:/viewSignUp";
		// �엯�젰諛쏆� �깮�씪 �삎�떇�쓣 DB�뿉 ���옣�맆 �삎�떇�쑝濡� 蹂�寃�
		String birtday = signUpDTO.getBirthday().replace("-", "");
		signUpDTO.setBirthday(birtday);

		// �엯�젰諛쏆� �룿踰덊샇 �삎�떇�쓣 DB�뿉 ���옣�맆 �삎�떇�쑝濡� 蹂�寃�
		// 01012345678 �쓽 �삎�떇(-媛� �뾾�뒗 �삎�떇�씠 寃쎌슦)
		if (signUpDTO.getPhone_number().length() == 11) {
			String phone = signUpDTO.getPhone_number().substring(0, 3) + "-"
					+ signUpDTO.getPhone_number().substring(3, 7) + "-" + signUpDTO.getPhone_number().substring(7, 11);
			signUpDTO.setPhone_number(phone);
		}
		
		// 蹂꾨챸(nickname)�쓣 �엯�젰�븯吏� �븡�븯�쓣 寃쎌슦
		if (signUpDTO.getNickname().equals("")) {
			UUID randomuuid = UUID.randomUUID();
			// member_name + 臾댁옉�쐞 8湲��옄濡� �땳�꽕�엫 ���옣
			// ex : �솉湲몃룞_44a9d39b
			signUpDTO.setNickname(signUpDTO.getMember_name() + "_" + randomuuid.toString().substring(0, 8));
		}


		// �엯�젰諛쏆� 二쇱냼+�긽�꽭二쇱냼
		// �슦�렪踰덊샇/二쇱냼/�긽�꽭二쇱냼
		signUpDTO.setAddress(signUpDTO.getAddress() + "/" + signUpDTO.getAddress2());

		// �꽦蹂� 誘몄꽑�깮�떆 null濡� �뱾�뼱�삤�뒗 �뜲�씠�꽣 泥섎━
		if (signUpDTO.getGender() == null) {
			signUpDTO.setGender("N");
		}

		try {
			if (memberService.signUp(signUpDTO) == 1) {
				System.out.println("insert�꽦怨�");
				result = "redirect:/";
			} else {
				System.out.println("insert�떎�뙣");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("insert�삁�쇅");
		}

		return result;
	}

	@RequestMapping(value = "/verifyCheck", method = RequestMethod.POST) // �쑕���룿 �씤利� 硫붿씪 �솗�씤 (ajax)
	public ResponseEntity<ResponseData> verifyCheck(@RequestParam("phone") String phone) {
		System.out.println(phone);
		// 010-1234-5678 �삎�떇�쓽(湲몄씠媛�13) 踰덊샇�씤 寃쎌슦
		if(phone.length()==13) {
			phone = phone.replace("-", ""); // 01012345678 �삎�떇�쑝濡� (湲몄씠 11)濡� 蹂��솚
		}
		
		ResponseEntity<ResponseData> result = null;
		try {
			remail.receiveMailPOP3(phone);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 濡쒓렇�븘�썐
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		HttpSession ses = request.getSession();
		ses.removeAttribute("loginMember");
		System.out.println("濡쒓렇�븘�썐");
		return "redirect:/";
	}

}
