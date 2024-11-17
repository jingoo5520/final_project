package com.finalProject.service.admin.notices;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.admin.notices.BannerVO;
import com.finalProject.persistence.admin.notices.BannerDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BannerServiceImpl implements BannerService {

	/*
	 * @Autowired private BannerDAO bDao;
	 * 
	 * private final String bannerPath = "C:/spring/temp/"; // 배너 이미지 저장 경로
	 * 
	 * @Override public void uploadBanner(MultipartFile file) { if (!file.isEmpty())
	 * { // 파일명 가져오기 String fileName = file.getOriginalFilename(); // 배너 파일 저장 경로
	 * File destinationFile = new File(bannerPath + fileName); try { // 파일 저장
	 * file.transferTo(destinationFile);
	 * 
	 * // 배너 정보 객체 생성 BannerVO banner = new BannerVO();
	 * banner.setFileName(fileName); banner.setFilePath(bannerPath + fileName); //
	 * 전체 경로 설정 // DB에 배너 정보 저장 bDao.insertBanner(banner); } catch (IOException e) {
	 * e.printStackTrace(); // 예외 처리 (로그 등) } } }
	 * 
	 * @Override public List<BannerVO> getAvailableBanners() { return
	 * bDao.getBanners(); // 배너 목록 조회 }
	 * 
	 * @Override public void setSelectedBanner(String fileName) { // 선택된 배너를 DB나 설정
	 * 파일에 저장하는 로직 bDao.updateSelectedBanner(fileName); }
	 */
}
