package com.finalProject.controller.admin.notices;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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

import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.admin.notices.NoticeTypeStatus;
import com.finalProject.model.admin.notices.NoticeVO;
import com.finalProject.model.admin.notices.PagingInfoDTO;
import com.finalProject.model.admin.notices.SearchCriteriaDTO;
import com.finalProject.service.admin.notices.FileService;
import com.finalProject.service.admin.notices.NoticeService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/admin/notices")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
    @Autowired
    private FileService fileService;
	
    private List<NoticeDTO> cachedNotices;
    private List<NoticeDTO> cachedEvents;
    
    private static final String UPLOAD_DIR = "C:/spring/temp/";

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
	public String createEvent(@ModelAttribute NoticeDTO noticeDTO, Model model) {
		//	    System.out.println("Notice Content: " + noticeDTO.getNotice_content());
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

		private String saveFile(MultipartFile file, String prefix) throws IOException {
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
		    Path path = Paths.get("C:/spring/temp/" + uniqueFileName);
		    
		    // 파일 저장
		    try (InputStream inputStream = file.getInputStream()) {
		        Files.copy(inputStream, path, StandardCopyOption.REPLACE_EXISTING);
		    }

		    // 저장된 파일의 경로 반환
		    logger.info("파일이 저장되었습니다: {}", path.toString());
		    return uniqueFileName; // 또는 절대 경로
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
	public String addEvent(@RequestParam("thumbnail") MultipartFile thumbnail,
	                       @RequestParam("banner_image") MultipartFile bannerImage, // 배너 이미지 추가
	                       @RequestParam("noticeTitle") String noticeTitle,
	                       @RequestParam("adminId") String adminId,
	                       @RequestParam("noticeType") String noticeType,
	                       @RequestParam("noticeContent") String noticeContent,
	                       @RequestParam("eventStartDate") String eventStartDate,
	                       @RequestParam("eventEndDate") String eventEndDate,
	                       RedirectAttributes redirectAttributes, 
	                       Model model) {

	    // noticeTitle이 null인 경우 에러 처리
	    if (noticeTitle == null || noticeTitle.isEmpty()) {
	        redirectAttributes.addAttribute("error", "제목은 필수 입력 사항입니다.");
	        return "redirect:/admin/notices/createEvent";
	    }

	    String thumbnailPath = "";
	    String bannerPath = ""; // 배너 이미지 경로 초기화

	    // 썸네일 이미지 처리
	    if (!thumbnail.isEmpty()) {
	        String uploadDir = "C:/spring/temp/";
	        String originalFilename = thumbnail.getOriginalFilename();
	        String newFilename = "event_thumbnail_" + UUID.randomUUID().toString() + "_" + originalFilename;

	        try {
	            File destinationFile = new File(uploadDir + newFilename);
	            thumbnail.transferTo(destinationFile);
	            thumbnailPath = "/post/summernoteImages/" + newFilename;
	            System.out.println("썸네일 저장 성공: " + thumbnailPath);
	        } catch (IOException e) {
	            e.printStackTrace();
	            model.addAttribute("error", "썸네일 이미지 업로드 실패");
	            return "errorPage"; // 에러 페이지로 리디렉션
	        }
	    }

	    // 배너 이미지 처리
	    if (!bannerImage.isEmpty()) {
	        String uploadDir = "C:/spring/temp/";
	        String originalFilename = bannerImage.getOriginalFilename();
	        String newFilename = "event_banner_" + UUID.randomUUID().toString() + "_" + originalFilename;

	        try {
	            File destinationFile = new File(uploadDir + newFilename);
	            bannerImage.transferTo(destinationFile);
	            bannerPath = "/post/summernoteImages/" + newFilename;
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

//	    // 날짜 포맷 지정
//	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
//	    try {
//	        LocalDate startDate = LocalDate.parse(eventStartDate, formatter);
//	        LocalDate endDate = LocalDate.parse(eventEndDate, formatter);
//	        LocalDateTime startDateTime = startDate.atStartOfDay();
//	        LocalDateTime endDateTime = endDate.atStartOfDay();
//	        event.setEvent_start_date(startDateTime); // LocalDateTime으로 설정
//	        event.setEvent_end_date(endDateTime); // LocalDateTime으로 설정
//	    } catch (DateTimeParseException e) {
//	        redirectAttributes.addAttribute("error", "날짜 형식이 올바르지 않습니다.");
//	        return "redirect:/admin/notices/createEvent";
//	    }

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
	        List<NoticeDTO> events = noticeService.getAllEvents(10, 1);
	        log.info("업로드 성공:", event);
	        redirectAttributes.addFlashAttribute("events", events);
	        redirectAttributes.addFlashAttribute("message", "이벤트가 등록되었습니다.");
	        return "redirect:/admin/notices/event"; // 이벤트 목록 페이지로 리디렉션
	    } catch (Exception e) {
	        log.error("이벤트 저장 실패: ", e); // 에러의 상세 내용을
	        return "redirect:/admin/notices/createEvent";
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
            log.error("이벤트 조회 실패: " + e.getMessage());
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
        System.out.println("Received event update request: " + noticeDTO);

        // 기존 이벤트 정보 조회
        NoticeDTO existingEvent;
        try {
            existingEvent = noticeService.selectEventById(noticeDTO.getNotice_no());
        } catch (Exception e) {
            log.error("기존 이벤트 정보 조회 실패: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "이벤트 정보 조회 실패: " + e.getMessage());
            return "redirect:/admin/notices/editEvent/" + noticeDTO.getNotice_no();
        }

        // 새로운 시작 및 종료 날짜가 입력되지 않았다면 기존 날짜 유지
        if (noticeDTO.getEvent_start_date() == null) {
            noticeDTO.setEvent_start_date(existingEvent.getEvent_start_date());
        }
        if (noticeDTO.getEvent_end_date() == null) {
            noticeDTO.setEvent_end_date(existingEvent.getEvent_end_date());
        }

        // notice_type 기본값 설정
        if (noticeDTO.getNotice_type() == null) {
            noticeDTO.setNotice_type(NoticeTypeStatus.NoticeType.E); // 기본값 설정
        }

        try {
            // 썸네일 변경 시 기존 썸네일 파일 삭제
            if (noticeDTO.getThumbnail_image() != null && !noticeDTO.getThumbnail_image().isEmpty()) {
                // 기존 썸네일 삭제
                if (existingEvent.getThumbnail_image() != null && !existingEvent.getThumbnail_image().isEmpty()) {
                    fileService.deleteFile(existingEvent.getThumbnail_image());
                }
            } else {
                // 썸네일이 변경되지 않은 경우 기존 썸네일 유지
                noticeDTO.setThumbnail_image(existingEvent.getThumbnail_image());
            }

            // 배너 변경 시 기존 배너 파일 삭제
            if (noticeDTO.getBanner_image() != null && !noticeDTO.getBanner_image().isEmpty()) {
                // 기존 배너 삭제
                if (existingEvent.getBanner_image() != null && !existingEvent.getBanner_image().isEmpty()) {
                    fileService.deleteFile(existingEvent.getBanner_image());
                }
            } else {
                // 배너가 변경되지 않은 경우 기존 배너 유지
                noticeDTO.setBanner_image(existingEvent.getBanner_image());
            }

            // 이벤트 수정 수행
            noticeService.updateEvent(noticeDTO);
            redirectAttributes.addFlashAttribute("message", "이벤트 수정 완료");

            log.info("Event Title: " + noticeDTO.getNotice_title());
            log.info("Event Content: " + noticeDTO.getNotice_content());
            log.info("Updated NoticeDTO: " + noticeDTO);

        } catch (Exception e) {
            log.error("이벤트 수정 실패: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "이벤트 수정 실패: " + e.getMessage());
            return "redirect:/admin/notices/editEvent/" + noticeDTO.getNotice_no();
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
    public ResponseEntity<?> uploadBanner(@PathVariable("noticeNo") int noticeNo, @RequestParam("banner") MultipartFile banner) {
        log.info("배너 업로드 요청: noticeNo={}, file={}", noticeNo, banner.getOriginalFilename());

        if (banner.isEmpty()) {
            return ResponseEntity.badRequest().body("파일이 비어 있습니다.");
        }

        try {
            // 파일 저장 경로 설정
            String originalFileName = banner.getOriginalFilename();
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String fileName = "banner_" + UUID.randomUUID() + extension; // 확장자를 유지한 채로 파일 이름 생성
            String filePath = "C:/spring/temp/" + fileName; // 파일을 저장할 경로 설정
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
    public ResponseEntity<Map<String, String>> deleteBanner(@RequestParam("notice_no") int noticeNo) {
        String bannerPath = "C:/spring/temp/" + noticeNo + "_banner.jpg"; // 배너 파일 경로
        File bannerFile = new File(bannerPath);
        if (bannerFile.delete()) {
            return ResponseEntity.ok(Collections.singletonMap("message", "배너가 삭제되었습니다."));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Collections.singletonMap("message", "배너 삭제 실패"));
        }
    }

    // 썸네일 교체
    @PostMapping("/updateThumbnail/{noticeNo}")
    @ResponseBody
    public ResponseEntity<?> updateThumbnail(@PathVariable int noticeNo, @RequestParam("thumbnail") MultipartFile file) {
        String newThumbnailPath = "";
        try {
            String uploadDir = "C:/spring/temp/";
            newThumbnailPath = uploadDir + "thumbnail_" + noticeNo + "_" + UUID.randomUUID() + "_" + file.getOriginalFilename();
            
            File destinationFile = new File(newThumbnailPath);
            file.transferTo(destinationFile);
            
            if (!destinationFile.exists()) {
                logger.error("File not saved: " + newThumbnailPath);
                throw new Exception("File not saved.");
            }

            noticeService.updateThumbnailPath(noticeNo, newThumbnailPath);
            logger.info("Thumbnail updated successfully for noticeNo: " + noticeNo);

            return ResponseEntity.ok(Map.of("success", true, "newThumbnailPath", newThumbnailPath));
        } catch (Exception e) {
            logger.error("Error updating thumbnail: " + e.getMessage(), e);
            return ResponseEntity.badRequest().body(Map.of("success", false, "error", e.getMessage()));
        }
    }


    @PostMapping("/deleteThumbnail")
    public String deleteThumbnail(@RequestParam("noticeNo") int noticeNo,
                                  RedirectAttributes redirectAttributes) {
        // 썸네일 삭제 로직
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

    private String getThumbnailPath(int noticeNo) {
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
    @GetMapping("/notices")
    public String getNotices(
            @RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord,
            @RequestParam(value = "searchType", required = false, defaultValue = "notice_title") String searchType,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model) {
        
        try {
            // 검색 조건 및 페이징 정보 설정
            SearchCriteriaDTO criteria = new SearchCriteriaDTO();
            criteria.setSearchWord(searchWord);
            criteria.setSearchType(searchType);

            PagingInfoDTO pagingInfo = new PagingInfoDTO();
            pagingInfo.setPageNo(page);
            pagingInfo.setPagingSize(10); // 한 페이지당 공지사항 개수 설정

            // 공지사항 목록 가져오기
            List<NoticeDTO> notices = noticeService.getNotices(criteria, pagingInfo);
            model.addAttribute("notices", notices);
            model.addAttribute("currentPage", page);
            model.addAttribute("searchWord", searchWord);
            model.addAttribute("searchType", searchType);
            // 전체 공지사항 개수를 모델에 추가 (페이징 처리를 위해 사용)
            int totalNoticesCount = noticeService.getTotalPostCnt();
            model.addAttribute("totalNoticesCount", totalNoticesCount);
            model.addAttribute("totalPages", (totalNoticesCount + 9) / 10); // 페이지 수 계산
            
            
        } catch (Exception e) {
            e.printStackTrace();
            // 오류 처리 로직 추가
        }

        return "admin/pages/notices/notice"; // JSP 뷰의 경로
    }
}
    
