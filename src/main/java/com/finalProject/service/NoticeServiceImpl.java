package com.finalProject.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.NoticeDTO;
import com.finalProject.persistence.NoticeDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDAO nDao;

	@Override
	public List<NoticeDTO> getAllnotices() throws Exception {
		log.info("NoticeServiceImpl!!!");
		return nDao.getAllNotices();
	}

	@Override
	public List<String> addNotice(NoticeDTO notice, MultipartFile[] files) throws Exception {
		List<String> filePaths = new ArrayList<String>();
		for (MultipartFile MultipartFile : files) {
			if (!MultipartFile.isEmpty()) {
				String fileName = MultipartFile.getOriginalFilename();
				Path path = Paths.get("" + fileName);
				
				File file = path.toFile();
			try {
			MultipartFile.transferTo(file);
			filePaths.add(path.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
			}
//			nDao.addNotice(notice, file);
	}
		return filePaths;
	
}
}