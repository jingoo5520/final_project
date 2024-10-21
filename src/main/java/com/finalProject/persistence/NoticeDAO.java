package com.finalProject.persistence;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.NoticeDTO;
import com.finalProject.model.NoticeImagesDTO;

public interface NoticeDAO {

	// 공지사항 목록 조회
	List<NoticeDTO> getAllNotices() throws Exception;

	// 공지사항 저장
	void addNotice(NoticeDTO notice, MultipartFile[] file) throws Exception;


}
