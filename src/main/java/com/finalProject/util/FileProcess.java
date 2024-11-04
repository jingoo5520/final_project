package com.finalProject.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;

@Component // 스프링 컨테이너에게 객체를 만들어 관리하도록
public class FileProcess {

	public String makePath(String realPath) throws IOException {

		String[] ymd = makeCalentdarPath(realPath);
		makeDirectory(realPath, ymd);
		String saveFilePath = realPath + ymd[ymd.length - 1];
		
		return saveFilePath;
		// 파일이 실제 저장되는 경로: realPath + "년/월/일"

		/*
		 * String[] ymd = makeCalentdarPath(realPath); String newFileName = ""; //
		 * BoardUpFilesVODTO result = null;
		 * 
		 * makeDirectory(realPath, ymd);
		 * 
		 * String saveFilePath = realPath + ymd[ymd.length - 1];
		 * 
		 * File fileToSave = new File(saveFilePath + File.separator + newFileName); //
		 * 실제 저장 FileUtils.writeByteArrayToFile(fileToSave, upfile);
		 * 
		 * // 이미지 파일 -> 썸네일 String ext =
		 * originalFileName.substring(originalFileName.lastIndexOf(".") + 1); if
		 * (ImageMimeType.isImage(ext)) { //
		 * System.out.println("이미지입니다... 썸네일을 만들겠습니다."); String thumbImgName =
		 * makeThumbNailImage(saveFilePath, newFileName);
		 * 
		 * System.out.println("thumbImgName: " + thumbImgName);
		 * 
		 * String base64Str = makeBase64String(saveFilePath + File.separator +
		 * thumbImgName);
		 * 
		 * System.out.println("Base64: " + base64Str);
		 * 
		 * result = BoardUpFilesVODTO.builder().ext(ext).newFileName(ymd[2] +
		 * File.separator + newFileName)
		 * .originFileName(originalFileName).size(fileSize).base64Img(base64Str)
		 * .thumbFileName(ymd[2] + File.separator + thumbImgName).build();
		 * 
		 * System.out.println("result: " + result);
		 * 
		 * } else { // 이미지가 아닌 경우 result =
		 * BoardUpFilesVODTO.builder().ext(ext).newFileName(ymd[2] + File.separator +
		 * newFileName) .originFileName(originalFileName).size(fileSize).build(); }
		 * 
		 * return result;
		 */
	}

	private String[] makeCalentdarPath(String realPath) {
		// TODO Auto-generated method stub

		Calendar now = Calendar.getInstance();

		String year = File.separator + now.get(Calendar.YEAR) + "";
		String month = year + File.separator + new DecimalFormat("00").format(now.get(Calendar.MONTH) + 1);
		String date = month + File.separator + new DecimalFormat("00").format(now.get(Calendar.DATE));

		System.out.println("year: " + year);
		System.out.println("month: " + month);
		System.out.println("date: " + date);

		String[] ymd = { year, month, date };

		return ymd;
	}

	private void makeDirectory(String realPath, String[] ymd) {
		// 실제 directory 생성
		System.out.println(new File(realPath + ymd[ymd.length - 1]).exists());

		if (!new File(realPath + ymd[ymd.length - 1]).exists()) {
			for (String path : ymd) {
				File tmp = new File(realPath + path);
				if (!tmp.exists()) {
					tmp.mkdir();
				}
			}
		}
	}

}
