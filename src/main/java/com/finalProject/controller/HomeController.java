package com.finalProject.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.service.admin.notices.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	NoticeService noticeService;
	
	// 메인 배너 이미지 설정
    @GetMapping("/")
    public String homePage(Model model) {
        List<NoticeDTO> event = null; // 리스트 초기화
        try {
            event = noticeService.getBannersWithImages(); // 배너 이미지와 함께 이벤트 가져오기
            model.addAttribute("event", event);
            for (NoticeDTO ev : event) {
            	System.out.println(ev.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "배너 정보를 가져오는 중 오류가 발생했습니다.");
            return "errorPage"; // 에러 페이지로 리디렉션
        }
        
        return "/user/index"; // 메인 페이지의 JSP 또는 HTML 파일
    }
}
