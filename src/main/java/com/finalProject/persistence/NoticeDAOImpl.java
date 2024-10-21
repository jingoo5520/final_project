package com.finalProject.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.NoticeDTO;
import com.finalProject.model.NoticeImagesDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	SqlSession ses;
	
	private String ns = "com.finalProject.mappers.noticeMapper.";

	@Override
	public List<NoticeDTO> getAllNotices() throws Exception {
		
		log.info("NoticeDAOImpl!!!");
		
		return ses.selectList(ns + "getAllNotices");
	}

	@Override
	public void addNotice(NoticeDTO notice, MultipartFile[] file) throws Exception {
		ses.insert(ns + "saveNotices", notice);
	}

	
	
}
