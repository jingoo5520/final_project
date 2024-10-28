package com.finalProject.controller.admin.notices;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeTypeStatus;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.service.NoticeService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/admin/notices")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
    private List<NoticeDTO> cachedNotices;
    private List<NoticeDTO> cachedEvents;

//    @PostConstruct
//    public void init() {
//        loadNotices();
//    }

//     공지사항 목록
//    public void loadNotices() {
//    	
//        try {
//            cachedNotices = noticeService.getAllnotices();
//        } catch (Exception e) {
//            log.error("Failed to load notices: {}", e.getMessage());
//        }
//    }
    
    // 이벤트 목록
//     public void loadEvents(){
//         try {
//        	 cachedEvents = noticeService.getAllEvents();
//         } catch (Exception e) {
//             log.error("Failed to load events: {}", e.getMessage());
//         }
//     }
	
    // 공지사항 목록 페이지
    @RequestMapping("/notice")
    public String showNotices(@RequestParam(defaultValue = "1") int page, Model model) {
        int pagingSize = 10; // 한 페이지에 보여줄 게시글 수
        int startRowIndex = (page - 1) * pagingSize; // 시작 인덱스
        
        // 총 게시글 수 가져오기
        int totalPostCount = 0;
        try {
            totalPostCount = noticeService.getTotalPostCnt(); // 총 게시글 수 조회
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
            notices = noticeService.getAllNotices(pagingSize, startRowIndex); // 공지사항 조회
            model.addAttribute("notices", notices);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "공지 목록 리스팅 실패");
        }

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages); // 총 페이지 수 추가
        model.addAttribute("pagingSize", pagingSize);
        model.addAttribute("totalPostCount", totalPostCount); // 총 게시글 수 추가

        return "admin/pages/notices/notice"; // JSP 파일 경로
    }
	
	// 이벤트 목록 조회
	@RequestMapping("/event")
    public String showEvents(@RequestParam(defaultValue = "1") int page, Model model) {
        int pagingSize = 10; // 한 페이지에 보여줄 게시글 수
        int startRowIndex = (page - 1) * pagingSize; // 시작 인덱스
        
        // 총 게시글 수 가져오기
        int totalPostCount = 0;
        try {
            totalPostCount = noticeService.getTotalPostCnt(); // 총 게시글 수 조회
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
        	events = noticeService.getAllEvents(pagingSize, startRowIndex); // 공지사항 조회
            model.addAttribute("events", events);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "공지 목록 리스팅 실패");
        }

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages); // 총 페이지 수 추가
        model.addAttribute("pagingSize", pagingSize);
        model.addAttribute("totalPostCount", totalPostCount); // 총 게시글 수 추가

        return "admin/pages/notices/event"; // JSP 파일 경로
    }

	// 공지사항 작성 페이지 표시
	@RequestMapping("/createNotice")
	public String createNoticeForm(@ModelAttribute NoticeDTO noticeDTO, Model model) {
//	    System.out.println("Notice Content: " + noticeDTO.getNotice_content());
		return "admin/pages/notices/createNotice";
	}
	
	// 이벤트 작성 페이지 표시
	@RequestMapping("/createEvent")
	public String createEventForm(@ModelAttribute NoticeDTO noticeDTO, Model model) {
//	    System.out.println("Event Content: " + noticeDTO.getNotice_content());
		return "admin/pages/notices/createEvent";
	}
	
	// 공지사항 작성
	@PostMapping("/addNotice")
	public String addNotice(@RequestParam("noticeTitle") String noticeTitle,
				            @RequestParam("adminId") String adminId,
				            @RequestParam("noticeType") String noticeType,
				            @RequestParam("noticeContent") String noticeContent,
				            RedirectAttributes redirectAttributes, Model model) {

		NoticeVO notice = new NoticeVO();
		notice.setNoticeTitle(noticeTitle);
		notice.setAdminId(adminId);
		if ("N".equals(noticeType)) {
			notice.setNoticeType("N");
		} else if ("E".equals(noticeType)) {
			notice.setNoticeType("E");
		} else {
			redirectAttributes.addAttribute("error", "공지사항 저장 실패");
			return "redirect:/admin/notices/createNotice";
		}
		notice.setNoticeContent(noticeContent);
		
		log.info("noticeTitle: {}", noticeTitle);
		log.info("adminId: {}", adminId);
		log.info("noticeContent: {}", noticeContent);
		log.info("noticeContent length: {}", noticeContent.length());
		
		if (noticeContent.length() > 65535) {
		    noticeContent = noticeContent.substring(0, 65535);
		}
		
		try {
			noticeService.addNotice(notice);
//			model.addAttribute("notices", noticeService.getAllnotices());
			List<NoticeDTO> notices = noticeService.getAllNotices(10, 1);
			redirectAttributes.addFlashAttribute("notices", notices);
			redirectAttributes.addFlashAttribute("message", "공지사항이 등록되었씁니다.");
			return "redirect:/admin/notices/notice";
		} catch (Exception e) {
			redirectAttributes.addAttribute("error", "공지사항 저장 실패 : " + e.getMessage());
			return "redirect:/admin/notices/notice";
		}
	}
	
	// 이벤트 작성
	@PostMapping("/addEvent")
	public String addEvent(@RequestParam("noticeTitle") String noticeTitle,
				            @RequestParam("adminId") String adminId,
				            @RequestParam("noticeType") String noticeType,
				            @RequestParam("noticeContent") String noticeContent,
				            RedirectAttributes redirectAttributes, Model model) {

	    System.out.println("Title: " + noticeTitle);
	    System.out.println("Admin ID: " + adminId);
	    System.out.println("Content: " + noticeContent); // 이 값 확인
		
		NoticeVO event = new NoticeVO();
		event.setNoticeTitle(noticeTitle);
		event.setAdminId(adminId);
		event.setNoticeContent(noticeContent);
		
		if ("E".equals(noticeType)) {
			event.setNoticeType("E");
		} else if ("N".equals(noticeType)) {
			event.setNoticeType("N");
		} else {
			redirectAttributes.addAttribute("error", "이벤트 저장 실패");
			return "redirect:/admin/notices/createEvent";
		}

		
		log.info("noticeTitle: {}", noticeTitle);
		log.info("adminId: {}", adminId);
		log.info("noticeContent: {}", noticeContent);
		log.info("noticeContent length: {}", noticeContent.length());
		
		if (noticeContent.length() > 65535) {
		    noticeContent = noticeContent.substring(0, 65535);
		}
		
		try {
			noticeService.addEvent(event);
			List<NoticeDTO> events = noticeService.getAllEvents(10, 1);
			redirectAttributes.addFlashAttribute("events", events);
			redirectAttributes.addFlashAttribute("message", "이벤트가 등록되었씁니다.");
			return "redirect:/admin/notices/event";
		} catch (Exception e) {
			redirectAttributes.addAttribute("error", "이벤트 저장 실패 : " + e.getMessage());
			return "redirect:/admin/notices/event";
		}
	}

    // 공지사항 수정 페이지 표시
    @GetMapping("/editNotice/{notice_no}")
    public String showEditNoticeForm(@PathVariable("notice_no") int noticeNo, Model model) {
        NoticeDTO notice;
		try {
			notice = noticeService.selectNoticeById(noticeNo);
			model.addAttribute("notice", notice);
		} catch (Exception e) {
			log.error("공지사항 조회 실패" + e.getMessage());
			return "redirect:/admin/notices/notice";
		}
        return "admin/pages/notices/editNotice"; // editNotice.jsp를 반환
    }
    
    // 이벤트 수정 페이지 표시
    @GetMapping("/editEvent/{notice_no}")
    public String showEditEventForm(@PathVariable("notice_no") int noticeNo, Model model) {
        NoticeDTO event;
		try {
			event = noticeService.selectEventById(noticeNo);
			model.addAttribute("event", event);
		} catch (Exception e) {
			log.error("이벤트 조회 실패" + e.getMessage());
			return "redirect:/admin/notices/event";
		}
        return "admin/pages/notices/editEvent"; // editEvent.jsp를 반환
    }

    // 공지사항 수정
    @PostMapping("/updateNotice")
    public String updateNotice(@ModelAttribute NoticeDTO noticeDTO, RedirectAttributes redirectAttributes) {
    	log.info("수정할 공지사항 번호: " + noticeDTO.getNotice_no());
        if (noticeDTO.getNotice_type() == null) {
            noticeDTO.setNotice_type(NoticeTypeStatus.NoticeType.N); // 기본값 설정
        }
        try {
			noticeService.updateNotice(noticeDTO);
			redirectAttributes.addFlashAttribute("message", "공지사항 수정 완료");
		} catch (Exception e) {
			log.error("공지사항 수정 실패" + e.getMessage());
			redirectAttributes.addFlashAttribute("error", "공지사항 수정 실패.." + e.getMessage());
			return "redirect:/admin/notices/editNotice/" + noticeDTO.getNotice_no();
		}
        return "redirect:/admin/notices/notice"; // 공지사항 목록 페이지로
    }
    
    // 이벤트 수정
    @PostMapping("/updateEvent")
    public String updateEvent(@ModelAttribute NoticeDTO noticeDTO, RedirectAttributes redirectAttributes) {
    	log.info("수정할 공지사항 번호: " + noticeDTO.getNotice_no());
        if (noticeDTO.getNotice_type() == null) {
            noticeDTO.setNotice_type(NoticeTypeStatus.NoticeType.E); // 기본값 설정
        }
        try {
			noticeService.updateEvent(noticeDTO);
			redirectAttributes.addFlashAttribute("message", "이벤트 수정 완료");
		    System.out.println("Event Title: " + noticeDTO.getNotice_title());
		    System.out.println("Event Content: " + noticeDTO.getNotice_content()); 
		    System.out.println("NoticeDTO: " + noticeDTO);

		} catch (Exception e) {
			log.error("이벤트 수정 실패" + e.getMessage());
			redirectAttributes.addFlashAttribute("error", "이벤트 수정 실패.." + e.getMessage());
			return "redirect:/admin/notices/editEvent/" + noticeDTO.getNotice_no();
		}
        return "redirect:/admin/notices/event"; // 공지사항 목록 페이지로
    }
    
    // 공지사항 삭제
    @RequestMapping(value = "/deleteNotice", method = RequestMethod.POST)
    public String deleteNotice(@RequestParam("notice_no") int noticeNo,
    							HttpServletRequest request, RedirectAttributes redirectAttributes) {
    try {
		noticeService.deleteNotice(noticeNo);
		redirectAttributes.addAttribute("message", "공지사항 삭제 완료");
	} catch (Exception e) {
		e.printStackTrace();
		redirectAttributes.addAttribute("error", "공지사항 삭제 실패");
	}
    return "redirect:/admin/notices/notice"; // 공지사항 목록 페이지로
    	
    }
    
    // 이벤트 삭제
    @RequestMapping(value = "/deleteEvent", method = RequestMethod.POST)
    public String deleteEvent(@RequestParam("notice_no") int noticeNo,
    							HttpServletRequest request, RedirectAttributes redirectAttributes) {
    try {
		noticeService.deleteEvent(noticeNo);
		redirectAttributes.addAttribute("message", "이벤트 삭제 완료");
	} catch (Exception e) {
		e.printStackTrace();
		redirectAttributes.addAttribute("error", "이벤트 삭제 실패");
	}
    return "redirect:/admin/notices/event"; // 이벤트 목록 페이지로
    	
    }
    
    // 공지사항 상세 페이지 조회
    @GetMapping("/viewNotice/{noticeNo}")
    public String viewNotice(@PathVariable("noticeNo") int noticeNo, Model model) {
    	NoticeDTO notice;
		try {
			notice = noticeService.selectNoticeById(noticeNo);
			model.addAttribute("notice", notice);
			return "admin/pages/notices/viewNotice";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "상세 조회 실패");
			return "errorPage";
		}
    }
    
    // 이벤트 상세 페이지 조회
    @GetMapping("/viewEvent/{noticeNo}")
    public String viewEvent(@PathVariable("noticeNo") int noticeNo, Model model) {
    	NoticeDTO event;
		try {
			event = noticeService.selectEventById(noticeNo);
			model.addAttribute("event", event);
			return "admin/pages/notices/viewEvent";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "상세 조회 실패");
			return "errorPage";
		}
    }
    
}
