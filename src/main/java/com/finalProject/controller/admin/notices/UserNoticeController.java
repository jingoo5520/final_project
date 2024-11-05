package com.finalProject.controller.admin.notices;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.service.admin.notices.UserNoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserNoticeController {

    private static final Logger log = LoggerFactory.getLogger(UserNoticeController.class);

    @Autowired
    private UserNoticeService userNoticeService;

    // 공지사항 목록 조회
    @GetMapping("/notices/notice")
    public String showUserNoticePage(@RequestParam(defaultValue = "1") int page,Model model) {
        log.info("공지사항 목록 요청을 처리합니다."); // 요청 로그 추가
        int pagingSize = 10; // 한 페이지에 보여줄 게시글 수
        int startRowIndex = (page - 1) * pagingSize; // 시작 인덱스
        
        // 총 게시글 수 가져오기
        int totalPostCount = 0;
        try {
            totalPostCount = userNoticeService.getTotalPostCnt(); // 총 게시글 수 조회
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "총 게시글 리스팅 실패");
        }
        
        int totalPages = (int) Math.ceil((double) totalPostCount / pagingSize); // 총 페이지 수 계산

        // 페이지 유효성 체크
        if (page > totalPages && totalPages > 0) {
            page = totalPages; // 요청한 페이지가 총 페이지 수보다 크면 마지막 페이지로 설정
        }

        List<NoticeDTO> notices = null;
        try {
            notices = userNoticeService.getAllNotices(pagingSize, startRowIndex); // 공지사항 조회
            model.addAttribute("notices", notices);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "공지 목록 리스팅 실패");
        }

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages); // 총 페이지 수 추가
        model.addAttribute("pagingSize", pagingSize);
        model.addAttribute("totalPostCount", totalPostCount); // 총 게시글 수 추가

        return "/user/pages/notices/userViewNotice"; // JSP 파일 경로
    }

    // 공지사항 상세 조회
    @GetMapping("/notices/userViewNoticeDetail/{noticeNo}")
    public String getNoticeDetail(@PathVariable("noticeNo") int noticeNo, Model model) {
        NoticeDTO notices;
		try {
			notices = userNoticeService.getNoticeDetail(noticeNo);
			model.addAttribute("notices", notices);
			return "user/pages/notices/userViewNoticeDetail";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "상세 조회 실패");
			return "errorPage";
		}
    }

    // 이벤트 목록 조회
    @GetMapping("/notices/event")
    public String showUserEventPage(@RequestParam(defaultValue = "1") int page,Model model) {
    	int pagingSize = 10; // 한 페이지에 보여줄 게시글 수
        int startRowIndex = (page - 1) * pagingSize; // 시작 인덱스
        
        // 총 게시글 수 가져오기
        int totalPostCount = 0;
        try {
            totalPostCount = userNoticeService.getTotalPostCnt(); // 총 게시글 수 조회
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "총 게시글 리스팅 실패");
        }
        
        int totalPages = (int) Math.ceil((double) totalPostCount / pagingSize); // 총 페이지 수 계산

        // 페이지 유효성 체크
        if (page > totalPages && totalPages > 0) {
            page = totalPages; // 요청한 페이지가 총 페이지 수보다 크면 마지막 페이지로 설정
        }

        List<NoticeDTO> events = null;
        try {
        	events = userNoticeService.getAllEvents(pagingSize, startRowIndex); // 공지사항 조회
            model.addAttribute("events", events);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "공지 목록 리스팅 실패");
        }

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages); // 총 페이지 수 추가
        model.addAttribute("pagingSize", pagingSize);
        model.addAttribute("totalPostCount", totalPostCount); // 총 게시글 수 추가

        return "user/pages/notices/userViewEvent"; // JSP 파일 경로
    }

    // 이벤트 상세 조회
    @GetMapping("/notices/userViewEventDetail/{noticeNo}")
    public String getEventDetail(@PathVariable("noticeNo") int noticeNo, Model model) {
        if (noticeNo <= 0) {
            model.addAttribute("error", "유효하지 않은 요청입니다.");
            return "errorPage";
        }

        NoticeDTO event;
        try {
            event = userNoticeService.getEventDetail(noticeNo);
            if (event == null) {
                model.addAttribute("error", "이벤트를 찾을 수 없습니다.");
                return "errorPage";
            }
            model.addAttribute("event", event);
            return "user/pages/notices/userViewEventDetail";
        } catch (Exception e) {
            model.addAttribute("error", "상세 조회 실패");
            return "errorPage";
        }
    }

}

    // 이벤트 배너 클릭 시 상세 조회
//    @GetMapping("/event/{noticeNo}")
//    public String getEventDetail(@PathVariable int noticeNo, Model model) {
//        NoticeVO event = userNoticeService.getNoticeById(noticeNo);
//        model.addAttribute("event", event);
//        return "eventDetail";
//    }
    
//    // 이벤트 배너 목록
//    @GetMapping("/user/banner")
//    public String getEventBanners(Model model) {
//        List<NoticeVO> events = userNoticeService.getEventBanners();  // 이벤트와 배너 이미지를 가져오는 메서드
//        model.addAttribute("events", events);
//        return "user/eventList";
//    }
