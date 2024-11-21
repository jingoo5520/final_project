package com.finalProject.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.inquiry.InquiryImgDTO;

@Component // 스프링 컨테이너에게 객체를 만들어 관리하도록
public class FileProcess {

	public List<InquiryImgDTO> saveFiles(MultipartFile[] files, String realPath) throws Exception {

		List<InquiryImgDTO> list = new ArrayList<InquiryImgDTO>();

		String saveFilePath = makePath(realPath);

		for (MultipartFile file : files) {
			
			String newFileName = "";

			if (checkFileExist(saveFilePath, file.getOriginalFilename())) {
				newFileName = renameFileName(file.getOriginalFilename());
			} else {
				newFileName = file.getOriginalFilename();
			}

			byte[] upfile = file.getBytes();
			File fileToSave = new File(saveFilePath + File.separator + newFileName);
			FileUtils.writeByteArrayToFile(fileToSave, upfile);
			String fullPath = saveFilePath + File.separator + newFileName;

			System.out.println("fileseperator: " + File.separator);
			
			int index = fullPath.indexOf(File.separator + "resources" + File.separator + "inquiryImages");
			String uri = fullPath.substring(index);

			InquiryImgDTO imgDTO = InquiryImgDTO.builder().inquiry_image_uri(uri).inquiry_image_name(newFileName)
					.inquiry_image_original_name(file.getOriginalFilename()).build();

			list.add(imgDTO);
			
		}

		return list;
	}

	public String makePath(String realPath) throws IOException {
		String[] ymd = makeCalentdarPath(realPath);
		makeDirectory(realPath, ymd);
		String saveFilePath = realPath + ymd[ymd.length - 1];

		return saveFilePath;
	}

	private String[] makeCalentdarPath(String realPath) {
		// TODO Auto-generated method stub

		Calendar now = Calendar.getInstance();

		String year = File.separator + now.get(Calendar.YEAR) + "";
		String month = year + File.separator + new DecimalFormat("00").format(now.get(Calendar.MONTH) + 1);
		String date = month + File.separator + new DecimalFormat("00").format(now.get(Calendar.DATE));

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

	private boolean checkFileExist(String saveFilePath, String originalFileName) {
		// 파일이름 중복검사
		// 중복된 파일이 있다면 true, 없다면 false 반환

		boolean isFind = false;
		File tmp = new File(saveFilePath);

		// 모든 dir, file 불러오기
		String[] dirs = tmp.list();

		if (dirs != null) {
			for (String dir : dirs) {
				if (dir.equals(originalFileName)) {
					System.out.println("같은 이름의 파일 존재");
					isFind = true;
					break;
				}
			}
		}

		if (!isFind) {
			System.out.println("같은 이름의 파일이 없음");
		}

		return isFind;
	}

	private String renameFileName(String originalFileName) {

		String timestamp = System.currentTimeMillis() + "";
		String uuid = UUID.randomUUID().toString();

		System.out.println("originalFileName: " + originalFileName);

		String[] temp = originalFileName.split("\\.");

		String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
		String name = originalFileName.substring(0, originalFileName.lastIndexOf("."));

		String newFileName = temp[0] + "_" + timestamp + "." + ext;
		System.out.println(newFileName);

		return newFileName;
	}
	
	public boolean deleteFile(String deleteFileName) {
		// realPath + 년월일경로 + 파일이름.확장자
		// 업로드된 파일을 하드디스크에서 삭제

		boolean result = false;

		File tmpFile = new File(deleteFileName);
		System.out.println(tmpFile);
		
		if (tmpFile.exists()) {
			System.out.println(tmpFile + "있음");
			result = tmpFile.delete();
		}

		return result;
	}

}
