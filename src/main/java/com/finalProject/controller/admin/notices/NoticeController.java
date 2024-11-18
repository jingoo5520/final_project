package com.finalProject.controller.admin.notices;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeTypeStatus;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.PagingInfoNoticeDTO;
import com.finalProject.service.admin.notices.FileService;
import com.finalProject.service.admin.notices.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/notices")
public class NoticeController {

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime dateTime;
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private FileService fileService;

	private List<NoticeDTO> cachedNotices;
	private List<NoticeDTO> cachedEvents;

	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

//    private static final String UPLOAD_DIR = "C:/spring/temp/";

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
	public String showNotices(Model model) {
		Map<String, Object> data = new HashMap<String, Object>();
		
		try {
			data = noticeService.getAllNotices(new PagingInfoNoticeDTO(1, 10, 5)); // 공지사항 조회
			
			model.addAttribute("notices", data.get("list"));
			model.addAttribute("pi", data.get("pi"));
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "공지 목록 리스팅 실패");
		}

		return "admin/pages/notices/notice"; // JSP 파일 경로
	}
	
	@GetMapping("/getNotices")
	@ResponseBody
	public Map<String, Object> getNotices(@RequestParam int pageNo) {
		System.out.println("pageNo" + pageNo);
		Map<String, Object> data = new HashMap<String, Object>();
		
		try {
			data = noticeService.getAllNotices(new PagingInfoNoticeDTO(pageNo, 10, 5)); // 공지사항 조회
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

//	// Ajax로 공지사항 목록을 불러오는 메서드
//	@GetMapping("/notice/getNoticeListWithPi")
//	@ResponseBody
//	public Map<String, Object> getNoticeList(@RequestParam int pageNo, @RequestParam int pagingSize,
//	                                         @RequestParam int pageCntPerBlock) {
//
//	    Map<String, Object> data = new HashMap<String, Object>();
//
//	    try {
//	        // NoticeService에서 페이지네이션에 맞는 공지사항 리스트를 조회
//	        PagingInfoNoticeDTO pagingInfo = new PagingInfoNoticeDTO(pageNo, pagingSize, pageCntPerBlock);
//	        data = noticeService.getNoticeList(pagingInfo);
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//
//	    return data;
//	}
	
	// 이벤트 목록 조회
	@RequestMapping("/event")
	public String showEvents(Model model) {

	Map<String, Object> data = new HashMap<String, Object>();
	
		try {
			data = noticeService.getAllEvents(new PagingInfoNoticeDTO(1, 10, 5)); // 이벤트 조회
		
			model.addAttribute("events", data.get("list"));
			model.addAttribute("pi", data.get("pi"));
		
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "이벤트 목록 리스팅 실패");
		}

		return "admin/pages/notices/event"; // JSP 파일 경로
	}
	
	@GetMapping("/getEvents")
	@ResponseBody
	public Map<String, Object> getEvents(@RequestParam int pageNo) {
		System.out.println("pageNo" + pageNo);
		Map<String, Object> data = new HashMap<String, Object>();
		
		try {
			data = noticeService.getAllEvents(new PagingInfoNoticeDTO(pageNo, 10, 5)); // 공지사항 조회
			System.out.println(data);
			
	        // LocalDateTime 포맷팅
	        List<NoticeDTO> events = (List<NoticeDTO>) data.get("list");
	         for (NoticeDTO event : events) {
	        	 System.out.println(event);
	        	 
	             // notice.getReg_date()가 LocalDateTime이라면
	             String formattedDate = event.getReg_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	             event.setReg_date(null);
	             event.setFormatted_reg_date(formattedDate);
	          
	             if (event.getEvent_start_date() != null) {
	             String formattedStartDate = event.getEvent_start_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	             event.setEvent_start_date(null);
	             event.setFormatted_event_start_date(formattedStartDate);
	             }
	             
	             if (event.getEvent_end_date() != null) {
	             String formattedEndDate = event.getEvent_end_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	             event.setEvent_end_date(null);
	             event.setFormatted_event_end_date(formattedEndDate);
	             }
	             
	         }
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data; // JSP 파일 경로
	}
	

	// 공지사항 작성 페이지 표시
	@RequestMapping("/createNotice")
	public String createNoticeForm(Model model, HttpServletRequest request) {
		// System.out.println("Notice Content: " + noticeDTO.getNotice_content());

		// 관리자 로그인 세션으로 받아오기
		HttpSession session = request.getSession();
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		model.addAttribute("adminId", loginMember.getMember_id());
		System.out.println(loginMember.getMember_id());

		return "admin/pages/notices/createNotice";
	}

	// 이벤트 작성 페이지 표시
	@RequestMapping("/createEvent")
	public String createEvent(Model model, HttpServletRequest request) {
		// System.out.println("Notice Content: " + noticeDTO.getNotice_content());
		// 관리자 로그인 세션으로 받아오기
		HttpSession session = request.getSession();
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		model.addAttribute("adminId", loginMember.getMember_id());
		System.out.println(loginMember.getMember_id());
		return "admin/pages/notices/createEvent";
	}

	// 이벤트 저장 처리
//	@RequestMapping(value = "/saveEvent", method = RequestMethod.POST)
//	public String saveEvent(@ModelAttribute NoticeDTO noticeDTO, Model model,
//			@RequestParam("bannerImage") MultipartFile bannerImage,
//            @RequestParam("thumbnailImage") MultipartFile thumbnailImage) throws Exception {
//		try {
//			// 배너 이미지 저장
//			String bannerImagePath = saveFile(bannerImage, "banner_");
//	        if (Files.exists(Paths.get(bannerImagePath))) {
//	            System.out.println("배너 이미지가 성공적으로 저장되었습니다: " + bannerImagePath);
//	            noticeDTO.setBanner_image(bannerImagePath);
//	        } else {
//	            System.out.println("배너 이미지 저장 실패: " + bannerImagePath);
//	        }
//			// 썸네일 이미지 저장
//			String thumbnailImagePath = saveFile(thumbnailImage, "thumbnail_");
//	        if (Files.exists(Paths.get(thumbnailImagePath))) {
//	            System.out.println("썸네일 이미지가 성공적으로 저장되었습니다: " + thumbnailImagePath);
//	            noticeDTO.setThumbnail_image(thumbnailImagePath);
//	        } else {
//	            System.out.println("썸네일 이미지 저장 실패: " + thumbnailImagePath);
//	        }
//			// 이벤트 DB 저장 로직
//			noticeService.createEventImg(noticeDTO);
//		} catch (IOException e) {
//			e.printStackTrace();
//			return "admin/pages/notices/createEvent";
//		}
//		return "admin/pages/notices/event";
//	}

	private String saveFile(MultipartFile file, String prefix, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/eventImages/");

		// 파일이 비어있는 경우
		if (file.isEmpty()) {
			System.out.println("파일이 비어있습니다: " + file.getOriginalFilename());
			return null; // 또는 적절한 예외 처리
		}

		// 파일 형식 체크 (예: 이미지 파일만 허용)
		String contentType = file.getContentType();
		if (!contentType.startsWith("image/")) {
			System.out.println("허용되지 않는 파일 형식입니다: " + contentType);
			return null; // 또는 예외를 던질 수 있음
		}

		// 파일 이름 생성
		String originalFileName = file.getOriginalFilename();
		String uniqueFileName = prefix + UUID.randomUUID() + "_" + originalFileName;

		// 파일 저장 경로 지정
		Path path = Paths.get(realPath + uniqueFileName);

		// 파일 저장
		try (InputStream inputStream = file.getInputStream()) {
			Files.copy(inputStream, path, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 저장된 파일의 경로 반환
		logger.info("파일이 저장되었습니다: {}", path.toString());
		return uniqueFileName; // 또는 절대 경로
	}

	// 공지사항 작성
	@PostMapping("/addNotice")
	public String addNotice(@RequestParam("noticeTitle") String noticeTitle, @RequestParam("adminId") String adminId,
			@RequestParam("noticeType") String noticeType, @RequestParam("noticeContent") String noticeContent,
			RedirectAttributes redirectAttributes, HttpServletRequest request, Model model) {

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

			// 공지사항 번호 기반 URL 생성 및 설정
			if (notice.getNoticeNo() > 0) {
				String url = "/admin/notices/viewNotice/" + notice.getNoticeNo();
				notice.setUrl(url);
				noticeService.updateNoticeUrl(notice); // URL 업데이트
			}

//			model.addAttribute("notices", noticeService.getAllnotices());
			// List<NoticeDTO> notices = noticeService.getAllNotices(10, 1);
			// redirectAttributes.addFlashAttribute("notices", notices);
			redirectAttributes.addFlashAttribute("message", "공지사항이 등록되었씁니다.");
			return "redirect:/admin/notices/notice";
		} catch (Exception e) {
			redirectAttributes.addAttribute("error", "공지사항 저장 실패 : " + e.getMessage());
			return "redirect:/admin/notices/notice";
		}
	}

	// 이벤트 작성
	@PostMapping("/addEvent")
	public String addEvent(@RequestParam("thumbnail") MultipartFile thumbnail,
			@RequestParam("banner_image") MultipartFile bannerImage, // 배너 이미지 추가
			@RequestParam("noticeTitle") String noticeTitle, @RequestParam("adminId") String adminId,
			@RequestParam("noticeType") String noticeType, @RequestParam("noticeContent") String noticeContent,
			@RequestParam("eventStartDate") String eventStartDate, @RequestParam("eventEndDate") String eventEndDate,
			RedirectAttributes redirectAttributes, Model model, HttpServletRequest request, HttpSession session) {

		// noticeTitle이 null인 경우 에러 처리
		if (noticeTitle == null || noticeTitle.isEmpty()) {
			redirectAttributes.addAttribute("error", "제목은 필수 입력 사항입니다.");
			return "redirect:/admin/notices/createEvent";
		}

		String thumbnailPath = "";
		String bannerPath = ""; // 배너 이미지 경로 초기화

		// 썸네일 이미지 처리
		if (!thumbnail.isEmpty()) {
			String uploadDir = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
			String originalFilename = thumbnail.getOriginalFilename();
			String newFilename = "event_thumbnail_" + UUID.randomUUID().toString() + "_" + originalFilename;

			try {
				File destinationFile = new File(uploadDir + newFilename);
				thumbnail.transferTo(destinationFile);
				thumbnailPath = "/resources/eventImages/" + newFilename;
				System.out.println("썸네일 저장 성공: " + thumbnailPath);
			} catch (IOException e) {
				e.printStackTrace();
				model.addAttribute("error", "썸네일 이미지 업로드 실패");
				return "errorPage"; // 에러 페이지로 리디렉션
			}
		}

		// 배너 이미지 처리
		if (!bannerImage.isEmpty()) {
			String uploadDir = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
			String originalFilename = bannerImage.getOriginalFilename();
			String newFilename = "event_banner_" + UUID.randomUUID().toString() + "_" + originalFilename;

			try {
				File destinationFile = new File(uploadDir + newFilename);
				bannerImage.transferTo(destinationFile);
				bannerPath = "/resources/eventImages/" + newFilename;
				System.out.println("배너 저장 성공: " + bannerPath);
			} catch (IOException e) {
				e.printStackTrace();
				model.addAttribute("error", "배너 이미지 업로드 실패");
				return "errorPage"; // 에러 페이지로 리디렉션
			}
		}

		// 이벤트 정보 저장
		NoticeDTO event = new NoticeDTO();
		event.setThumbnail_image(thumbnailPath);
		event.setBanner_image(bannerPath); // 배너 이미지 경로 추가
		event.setNotice_title(noticeTitle); // noticeTitle 사용
		event.setNotice_content(noticeContent); // noticeContent 사용
		event.setAdmin_id(adminId); // adminId 사용
//	    event.setUrl(url);

		// 날짜 포맷 지정

		try {
			// eventStartDate와 eventEndDate가 제대로 전달되었는지 확인
			LocalDateTime startDateTime = LocalDateTime.parse(eventStartDate, formatter);
			LocalDateTime endDateTime = LocalDateTime.parse(eventEndDate, formatter);

			event.setEvent_start_date(startDateTime); // LocalDateTime으로 설정
			event.setEvent_end_date(endDateTime); // LocalDateTime으로 설정
		} catch (DateTimeParseException e) {
			e.printStackTrace();
			redirectAttributes.addAttribute("error", "날짜 형식이 올바르지 않습니다.");
			return "redirect:/admin/notices/createEvent";
		}

		// eventStartDate가 null인 경우 기본 날짜 설정
		if (event.getEvent_start_date() == null) {
			event.setEvent_start_date(LocalDateTime.now()); // 현재 날짜로 시작일을 설정
		}

		// eventEndDate가 null인 경우 종료일을 시작일 + 10로 설정
		if (event.getEvent_end_date() == null) {
			event.setEvent_end_date(LocalDateTime.now().plusDays(10)); // 종료일을 시작일 + 10로 설정
		}

		// noticeType 설정
		if ("E".equals(noticeType)) {
			event.setNotice_type(NoticeTypeStatus.NoticeType.E);
		} else if ("N".equals(noticeType)) {
			event.setNotice_type(NoticeTypeStatus.NoticeType.N);
		} else {
			redirectAttributes.addAttribute("error", "이벤트 저장 실패");
			return "redirect:/admin/notices/createEvent";
		}

		log.info("noticeTitle: {}", noticeTitle);
		log.info("adminId: {}", adminId);
		log.info("noticeContent: {}", noticeContent);
		log.info("noticeContent length: {}", noticeContent.length());

//	    if (noticeContent.length() > 65535) {
//	        noticeContent = noticeContent.substring(0, 65535);
//	    }

		try {
			noticeService.addEvent(event); // 이벤트 저장
//			List<NoticeDTO> events = noticeService.getAllEvents(10, 1);
			System.out.println("-------- event --------" + event);
			log.info("업로드 성공:", event);
//			redirectAttributes.addFlashAttribute("events", events);
			redirectAttributes.addFlashAttribute("message", "이벤트가 등록되었습니다.");
			return "redirect:/admin/notices/event"; // 이벤트 목록 페이지로 리디렉션
		} catch (Exception e) {
			log.error("이벤트 저장 실패: ", e); // 에러의 상세 내용을
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
			System.out.println(event);
		} catch (Exception e) {
			log.error("이벤트 조회 실패: " + e.getMessage());
			return "redirect:/admin/notices/event";
		}
		return "admin/pages/notices/editEvent"; // editEvent.jsp를 반환
	}

	// 공지사항 수정
	@PostMapping("/updateNotice")
	public String updateNotice(@ModelAttribute NoticeDTO noticeDTO, RedirectAttributes redirectAttributes,
			HttpSession session) {
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
	public String updateEvent(@RequestParam("notice_no") int noticeNo,
			@RequestParam("thumbnail_image2") MultipartFile thumbnail,
			@RequestParam("banner_image") MultipartFile bannerImage, // 배너 이미지 추가
			@RequestParam("notice_title") String noticeTitle, @RequestParam("admin_id") String adminId,
			@RequestParam("notice_type") String noticeType, @RequestParam("notice_content") String noticeContent,
			@RequestParam("event_start_date") String eventStartDate,
			@RequestParam("event_end_date") String eventEndDate, RedirectAttributes redirectAttributes, Model model,
			HttpServletRequest request, HttpSession session) {

		String thumbnailPath = "";
		String bannerPath = ""; // 배너 이미지 경로 초기화
		// 썸네일 이미지 처리

		System.out.println(thumbnail);

		if (!thumbnail.isEmpty()) {
			String uploadDir = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
			String originalFilename = thumbnail.getOriginalFilename();
			String newFilename = "event_thumbnail_" + UUID.randomUUID().toString() + "_" + originalFilename;

			try {
				File destinationFile = new File(uploadDir + newFilename);
				thumbnail.transferTo(destinationFile);
				thumbnailPath = "/resources/eventImages/" + newFilename;
				System.out.println("썸네일 저장 성공: " + thumbnailPath);
			} catch (IOException e) {
				e.printStackTrace();
				model.addAttribute("error", "썸네일 이미지 업로드 실패");
			}
		}

		// 배너 이미지 처리
		if (!bannerImage.isEmpty()) {
			String uploadDir = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
			String originalFilename = bannerImage.getOriginalFilename();
			String newFilename = "event_banner_" + UUID.randomUUID().toString() + "_" + originalFilename;

			try {
				File destinationFile = new File(uploadDir + newFilename);
				bannerImage.transferTo(destinationFile);
				bannerPath = "/resources/eventImages/" + newFilename;
				System.out.println("배너 저장 성공: " + bannerPath);
			} catch (IOException e) {
				e.printStackTrace();
				model.addAttribute("error", "배너 이미지 업로드 실패");
			}
		}

		LocalDateTime startDateTime = LocalDateTime.parse(eventStartDate, formatter);
		LocalDateTime endDateTime = LocalDateTime.parse(eventEndDate, formatter);

		NoticeDTO dto = NoticeDTO.builder().notice_no(noticeNo).notice_title(noticeTitle).admin_id(adminId)
				.event_start_date(startDateTime).event_end_date(endDateTime).thumbnail_image(thumbnailPath)
				.banner_image(bannerPath).notice_content(noticeContent).build();

		if ("E".equals(noticeType)) {
			dto.setNotice_type(NoticeTypeStatus.NoticeType.E);
		} else if ("N".equals(noticeType)) {
			dto.setNotice_type(NoticeTypeStatus.NoticeType.N);
		}

		System.out.println(dto);

		try {
			noticeService.updateEvent(dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "redirect:/admin/notices/event";

	}

	// 썸네일 저장 로직
//    private String saveThumbnail(MultipartFile file) throws IOException {
//        // 파일을 저장할 경로 설정
//        String uploadDir = "C:/spring/temp/";
//        String fileName = "event_" + UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
//        File targetFile = new File(uploadDir, fileName);
//
//        // 파일 저장
//        file.transferTo(targetFile);
//
//        // 파일 URL 반환
//        return "/post/" + fileName; // 클라이언트에서 접근할 수 있는 URL
//    }

	// 공지사항 삭제
	@RequestMapping(value = "/deleteNotice", method = RequestMethod.POST)
	public String deleteNotice(@RequestParam("notice_no") int noticeNo, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
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
	public String deleteEvent(@RequestParam("notice_no") int noticeNo, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
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
			// 모델에 이벤트 정보 추가
			model.addAttribute("event", event);
			model.addAttribute("eventStartDate", event.getEvent_start_date());
			model.addAttribute("eventEndDate", event.getEvent_end_date());

			System.out.println("Event Thumbnail: " + event.getThumbnail_image());
			return "admin/pages/notices/viewEvent";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "상세 조회 실패");
			return "errorPage";
		}
	}

	// 배너 업로드
	@PostMapping("/event/{noticeNo}/banner")
	public ResponseEntity<?> uploadBanner(@PathVariable("noticeNo") int noticeNo,
			@RequestParam("banner") MultipartFile banner, HttpServletRequest request) {
		log.info("배너 업로드 요청: noticeNo={}, file={}", noticeNo, banner.getOriginalFilename());
		String realPath = request.getSession().getServletContext().getRealPath("/resources/eventImages/");

		if (banner.isEmpty()) {
			return ResponseEntity.badRequest().body("파일이 비어 있습니다.");
		}

		try {
			// 파일 저장 경로 설정
			String originalFileName = banner.getOriginalFilename();
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			String fileName = "banner_" + UUID.randomUUID() + extension; // 확장자를 유지한 채로 파일 이름 생성
			String filePath = realPath + fileName; // 파일을 저장할 경로 설정
			File dest = new File(filePath);
			banner.transferTo(dest);

			log.info("파일이 성공적으로 저장되었습니다: {}", filePath);

			// JSON 응답 반환
			Map<String, String> response = new HashMap<>();
			response.put("fileName", fileName); // 파일 이름을 JSON으로 반환

			return ResponseEntity.ok(response); // Map을 JSON으로 반환
		} catch (IOException e) {
			log.error("파일 업로드 중 오류가 발생했습니다.", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 중 오류가 발생했습니다.");
		}
	}

	// 배너 삭제
	@DeleteMapping("/event/deleteBanner")
	public ResponseEntity<Map<String, String>> deleteBanner(@RequestParam("notice_no") int noticeNo,
			HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
		String bannerPath = realPath + noticeNo + "_banner.jpg"; // 배너 파일 경로
		File bannerFile = new File(bannerPath);
		if (bannerFile.delete()) {
			return ResponseEntity.ok(Collections.singletonMap("message", "배너가 삭제되었습니다."));
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Collections.singletonMap("message", "배너 삭제 실패"));
		}
	}

	// 배너 교체
	@PostMapping("/updateBanner/{noticeNo}")
	@ResponseBody
	public ResponseEntity<?> updateBanner(@PathVariable int noticeNo, @RequestParam("banner") MultipartFile file,
			HttpServletRequest request) {
		String newBannerPath = "";
		try {
			// 파일을 저장할 디렉토리 경로 (썸네일과 동일한 경로 사용)
			String uploadDir = request.getSession().getServletContext().getRealPath("/resources/eventImages/");

			// 배너 파일 경로 설정 (썸네일과 동일한 경로에 저장)
			newBannerPath = uploadDir + "banner_" + noticeNo + "_" + UUID.randomUUID() + "_"
					+ file.getOriginalFilename();

			// 파일을 해당 경로에 저장
			File destinationFile = new File(newBannerPath);
			file.transferTo(destinationFile);

			// 파일이 정상적으로 저장되지 않은 경우 예외 처리
			if (!destinationFile.exists()) {
				logger.error("File not saved: " + newBannerPath);
				throw new Exception("File not saved.");
			}

			// 'newBannerPath'의 절대 경로에서 '/resources/' 이후의 경로만 추출하여 상대 경로로 변환
			String relativePath = newBannerPath.replace(request.getSession().getServletContext().getRealPath("/"), "");

			// 경로 구분자 처리 (Windows에서 발생할 수 있는 '\'를 '/'로 변환)
			relativePath = relativePath.replace("\\", "/");

			// 상대 경로 앞에 '/resources'가 추가되지 않으면 추가
			if (!relativePath.startsWith("/")) {
				relativePath = "/" + relativePath;
			}

			// 상대 경로 확인
			System.out.println("relativePath : " + relativePath);

			// 서비스 계층을 통해 배너 경로 업데이트
			noticeService.updateBannerPath(noticeNo, relativePath);
			logger.info("Banner updated successfully for noticeNo: " + noticeNo);

			return ResponseEntity.ok(Collections.singletonMap("success", true));
		} catch (Exception e) {
			logger.error("Error updating banner: " + e.getMessage(), e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Collections.singletonMap("success", false));
		}
	}

	// 썸네일 교체
	@PostMapping("/updateThumbnail/{noticeNo}")
	@ResponseBody
	public ResponseEntity<?> updateThumbnail(@PathVariable int noticeNo, @RequestParam("thumbnail") MultipartFile file,
			HttpServletRequest request) {
		String newThumbnailPath = "";
		try {
			String uploadDir = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
			newThumbnailPath = uploadDir + "thumbnail_" + noticeNo + "_" + UUID.randomUUID() + "_"
					+ file.getOriginalFilename();

			File destinationFile = new File(newThumbnailPath);
			file.transferTo(destinationFile);

			if (!destinationFile.exists()) {
				logger.error("File not saved: " + newThumbnailPath);
				throw new Exception("File not saved.");
			}

			// 절대 경로에서 '/resources/' 이후의 경로만 추출 (상대 경로로)
			String relativePath = newThumbnailPath.replace(request.getSession().getServletContext().getRealPath("/"),
					"");

			relativePath = relativePath.replace("\\", "/");

			// 상대 경로 앞에 /resources를 붙여줌
			if (!relativePath.startsWith("/")) {
				relativePath = "/" + relativePath;
			}
			System.out.println("relativePath : " + relativePath);

			noticeService.updateThumbnailPath(noticeNo, relativePath);
			logger.info("Thumbnail updated successfully for noticeNo: " + noticeNo);

			return ResponseEntity.ok(Collections.singletonMap("success", true));
		} catch (Exception e) {
			logger.error("Error updating thumbnail: " + e.getMessage(), e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Collections.singletonMap("success", false));
		}
	}

	@PostMapping("/deleteThumbnail")
	public String deleteThumbnail(@RequestParam("noticeNo") int noticeNo, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		// 썸네일 삭제 로직
		String UPLOAD_DIR = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
		String thumbnailPath = UPLOAD_DIR + "notice_" + noticeNo + ".jpg"; // 파일 경로
		File file = new File(thumbnailPath);
		if (file.exists()) {
			if (file.delete()) {
				redirectAttributes.addFlashAttribute("message", "썸네일이 성공적으로 삭제되었습니다.");
			} else {
				redirectAttributes.addFlashAttribute("error", "썸네일 삭제 중 오류가 발생했습니다.");
			}
		} else {
			redirectAttributes.addFlashAttribute("error", "삭제할 썸네일이 존재하지 않습니다.");
		}

		return "redirect:/admin/pages/notice"; // 성공 시 리다이렉션
	}

	private String getThumbnailPath(int noticeNo, HttpServletRequest request) {
		String UPLOAD_DIR = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
		// 데이터베이스에서 썸네일 경로를 조회하는 로직
		// 예: return noticeService.getThumbnailPath(noticeNo);
		return UPLOAD_DIR + "notice_" + noticeNo + ".jpg"; // 예시 경로
	}

	// 파일 확장자 추출 메서드
	private String getFileExtension(String fileName) {
		if (fileName != null && fileName.contains(".")) {
			return fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
		}
		return ""; // 기본값
	}

	// 메인 배너 이미지 설정
//    @GetMapping("/")
//    public String mainPage(Model model) {
//        List<NoticeDTO> events = null; // 리스트 초기화
//        try {
//        	events = noticeService.getBannersWithImages(); // 배너 이미지와 함께 이벤트 가져오기
//            model.addAttribute("events", events);
//            for (NoticeDTO ev : events) {
//            	System.out.println(ev.toString());
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("error", "배너 정보를 가져오는 중 오류가 발생했습니다.");
//            return "errorPage"; // 에러 페이지로 리디렉션
//        }
//        
//        return "index"; // 메인 페이지의 JSP 또는 HTML 파일
//    }

	// 페이지네이션 검색 기능
//	@GetMapping("/notices")
//	@ResponseBody
//	public Map<String, Object> getNoticeList(@RequestParam int pageNo, @RequestParam int pagingSize,
//			@RequestParam int pageCntPerBlock) {
//
//		Map<String, Object> data = new HashMap<String, Object>();
//
//		try {
//			data = noticeService.getNotices(new PagingInfoNewDTO(pageNo, pagingSize, pageCntPerBlock));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return data;
//	}

//	public String getNotices(@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord,
//			@RequestParam(value = "searchType", required = false, defaultValue = "notice_title") String searchType,
//			@RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model) {
//
//		try {
//			// 검색 조건 및 페이징 정보 설정
//			SearchCriteriaDTO criteria = new SearchCriteriaDTO();
//			criteria.setSearchWord(searchWord);
//			criteria.setSearchType(searchType);
//
//			PagingInfoDTO pagingInfo = new PagingInfoDTO();
//			pagingInfo.setPageNo(page);
//			pagingInfo.setPagingSize(10); // 한 페이지당 공지사항 개수 설정
//
//			// 공지사항 목록 가져오기
//			List<NoticeDTO> notices = noticeService.getNotices(criteria, pagingInfo);
//			model.addAttribute("notices", notices);
//			model.addAttribute("currentPage", page);
//			model.addAttribute("searchWord", searchWord);
//			model.addAttribute("searchType", searchType);
//			// 전체 공지사항 개수를 모델에 추가 (페이징 처리를 위해 사용)
//			int totalNoticesCount = noticeService.getTotalPostCnt();
//			model.addAttribute("totalNoticesCount", totalNoticesCount);
//			model.addAttribute("totalPages", (totalNoticesCount + 9) / 10); // 페이지 수 계산
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			// 오류 처리 로직 추가
//		}
//
//		return "admin/pages/notices/notice"; // JSP 뷰의 경로
//	}

	// URL 업데이트 메서드
//    @RequestMapping(value = "/updateUrl", method = RequestMethod.POST)
//    @ResponseBody
//    public String updateNoticeUrl(
//            @RequestParam("noticeNo") int noticeNo,
//            @RequestParam("noticeType") String noticeType,
//            @RequestParam("url") String url) {
//
//        // NoticeVO 객체 생성 및 값 설정
//        NoticeVO noticeVO = new NoticeVO();
//        noticeVO.setNoticeNo(noticeNo);
//        noticeVO.setNoticeType(noticeType);
//        noticeVO.setUrl(url);
//
//        // NoticeService의 URL 업데이트 메서드 호출
//        boolean result;
//        try {
//            result = noticeService.updateNoticeUrl(noticeVO);
//            if (result) {
//                return "URL 업데이트 성공";
//            } else {
//                return "URL 업데이트 실패";
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "에러 발생: " + e.getMessage();
//        }
//    }

}
