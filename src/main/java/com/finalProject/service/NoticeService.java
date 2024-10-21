package com.finalProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.NoticeDTO;
import com.finalProject.model.NoticeImagesDTO;
import com.finalProject.persistence.NoticeDAO;

public interface NoticeService {
	
	// 공지사항 목록 조회
	public List<NoticeDTO> getAllnotices() throws Exception;

	// 공지사항 작성
	public List<String> addNotice(NoticeDTO notice, MultipartFile[] file) throws Exception;
}