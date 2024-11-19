package com.finalProject.controller.admin.notices;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.PagingInfoNoticeDTO;
import com.finalProject.service.admin.notices.UserNoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserNoticeController {

    private static final Logger log = LoggerFactory.getLogger(UserNoticeController.class);

    @Autowired
    private UserNoticeService userNoticeService;

    // 공지사항 목록 조회
    @GetMapping("/serviceCenter/notice")
    public String showUserNoticePage(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		Map<String, Object> data = new HashMap<String, Object>();

        try {
            data = userNoticeService.getAllNotices(new PagingInfoNoticeDTO(pageNo, 10, 5)); // 공지사항 조회
            model.addAttribute("notices", data.get("list"));
			model.addAttribute("pi", data.get("pi"));
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "공지 목록 리스팅 실패");
        }

        return "/user/pages/notices/userViewNotice"; // JSP 파일 경로
    }
    
    @GetMapping("/serviceCenter/notice/getNotices")
	@ResponseBody
	public Map<String, Object> getNotices(@RequestParam int pageNo) {
		System.out.println("pageNo" + pageNo);
		Map<String, Object> data = new HashMap<String, Object>();
		
		try {
			data = userNoticeService.getAllNotices(new PagingInfoNoticeDTO(pageNo, 10, 5)); // 공지사항 조회
			System.out.println(data);
			
	        // LocalDateTime 포맷팅
	        List<NoticeDTO> notices = (List<NoticeDTO>) data.get("list");
	         for (NoticeDTO notice : notices) {
	        	 System.out.println(notice);
	        	 
	             // notice.getReg_date()가 LocalDateTime이라면
	             String formattedDate = notice.getReg_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	             notice.setReg_date(null);
	             notice.setFormatted_reg_date(formattedDate);
	         }
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data; // JSP 파일 경로
	}

    // 공지사항 상세 조회
    @GetMapping("/serviceCenter/noticeDetail/{noticeNo}")
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
    @GetMapping("/event")
    public String showUserEventPage(@RequestParam(defaultValue = "1") int pageNo, Model model) {
    	Map<String, Object> data = new HashMap<String, Object>();
    	
		try {
			data = userNoticeService.getAllEvents(new PagingInfoNoticeDTO(pageNo, 9, 5)); // 이벤트 조회
			System.out.println("data" + data);
			
			model.addAttribute("events", data.get("list"));
			model.addAttribute("pi", data.get("pi"));
		
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "이벤트 목록 리스팅 실패");
		}
		
        return "user/pages/notices/userViewEvent"; // JSP 파일 경로
    }
    
	@GetMapping("/event/getEvents")
	@ResponseBody
	public Map<String, Object> getAllEvents(@RequestParam int pageNo) {
		System.out.println("pageNo" + pageNo);
		Map<String, Object> data = new HashMap<String, Object>();
		
		try {
			data = userNoticeService.getAllEvents(new PagingInfoNoticeDTO(pageNo, 9, 5)); // 공지사항 조회
			System.out.println("Returned data: " + data);
			
	        // LocalDateTime 포맷팅
	        List<NoticeDTO> events = (List<NoticeDTO>) data.get("list");
	        System.out.println("events list: " + events);
	        	
//	        for (NoticeDTO event : events) {
//	        	 System.out.println(event);
//	        	 
//	             // notice.getReg_date()가 LocalDateTime이라면
//	             String formattedDate = event.getReg_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//	             event.setReg_date(null);
//	             event.setFormatted_reg_date(formattedDate);
//	          
//	             if (event.getEvent_start_date() != null) {
//	             String formattedStartDate = event.getEvent_start_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//	             event.setEvent_start_date(null);
//	             event.setFormatted_event_start_date(formattedStartDate);
//	             }
//	             
//	             if (event.getEvent_end_date() != null) {
//	             String formattedEndDate = event.getEvent_end_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//	             event.setEvent_end_date(null);
//	             event.setFormatted_event_end_date(formattedEndDate);
//	             }
//	             
//	         }
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data; // JSP 파일 경로
	}

    // 이벤트 상세 조회
    @GetMapping("/eventDetail/{noticeNo}")
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
