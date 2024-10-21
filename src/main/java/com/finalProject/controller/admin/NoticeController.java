package com.finalProject.controller.admin;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.NoticeDTO;
import com.finalProject.model.NoticeImagesDTO;
import com.finalProject.model.NoticeTypeStatus;
import com.finalProject.model.NoticeTypeStatus.NoticeType;
import com.finalProject.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/pages")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;

	@GetMapping("/createNotice")
	public String addNotice(Model model) {
//		List<NoticeDTO> admins = null;
//		try {
//			admins = noticeService.getAllnotices();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		model.addAttribute("admins", admins);
		return "/admin/pages/createNotice";
	}
	
//	@RequestMapping(value="/createNotice", method = RequestMethod.POST)
	@PostMapping("/createNotice")
	public String Noticedata(@RequestParam("noticeTitle") String title,
							@RequestParam("adminId") String adminId,
							@RequestParam("noticeType") String type,
							@RequestParam("noticeContent") String content,
							@RequestParam(value="file", required = false) MultipartFile[] file, Model model) {
		
		NoticeType noticeType; // 문자열 -> enum
		try {
		noticeType = NoticeTypeStatus.NoticeType.valueOf(type);
		} catch(IllegalArgumentException e) {
			model.addAttribute("file", "유효하지 않은 : " + type);
			 return "/admin/pages/createNotice";
		}
		
		NoticeDTO notice = NoticeDTO.builder()
		        .noticeTitle(title)
		        .noticeContent(content)
		        .adminId(adminId)
		        .noticeType(noticeType)
		        .regDate(LocalDateTime.now())
		        .fileList(new ArrayList<>())
		        .build();
		
		notice.setRegDate(LocalDateTime.now());
		System.out.println(notice.toString());
		
		List<NoticeImagesDTO> fileList = new ArrayList<>();
		
		if (file != null) {
		for (MultipartFile MultipartFile : file) {
			if (!MultipartFile.isEmpty()) {
				NoticeImagesDTO noticeImage = new NoticeImagesDTO();
				noticeImage.setImageUrl(MultipartFile.getOriginalFilename());
				fileList.add(noticeImage);
			}
		}
	}
		notice.getFileList();
		notice.setFileList(fileList);
		
//		System.out.println("Title: " + notice.getNoticeTitle());
//		System.out.println("Content: " + notice.getNoticeContent());
//	    System.out.println(notice.toString());

		try {
			noticeService.addNotice(notice, file);
			model.addAttribute("success", "공지사항 등록 성공");
		return "redirect:/admin/pages/notice";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("fail", "공지사항 등록 실패");
		}
								 
		return "/admin/pages/createNotice";
	}

}