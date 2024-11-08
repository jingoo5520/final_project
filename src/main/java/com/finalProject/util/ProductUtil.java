package com.finalProject.util;

import java.io.File;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class ProductUtil {

	// 경로가 존재하지 않으면 디렉토리 생성
	public void makeDirectory(String realPath) {
		File file = new File(realPath);
		if (!file.exists()) {
			file.mkdirs();
		}
	}

	// 리스트에 있는 파일 삭제
	public boolean removeFile(List<String> filePaths) {
		boolean result = false;
		for (String filePath : filePaths) {
			File file = new File(filePath);
			if (file.exists()) {
				result = file.delete();
				System.out.println("삭제된 파일 경로: " + filePath);
			} else {
				System.out.println("파일이 존재하지 않음: " + filePath);
			}
		}
		return result;
	}

	// 단일 파일 삭제
	public boolean removeFile(String filePath) {
		File file = new File(filePath);
		if (file.exists()) {
			boolean deleted = file.delete();
			System.out.println("삭제된 파일 경로: " + filePath);
			return deleted;
		} else {
			System.out.println("파일이 존재하지 않음: " + filePath);
		}
		return false;
	}
}
