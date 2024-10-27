package com.finalProject.util;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

@Component
public class ProductUtil {

	public void makeDirectory(HttpServletRequest request, String realPath) {

		System.out.println(realPath);
		File file = new File(realPath);
		if (!new File(realPath).exists()) {
			file.mkdirs();
		}
	}

	public boolean removeFile(List<String> list) {
		// TODO Auto-generated method stub
		boolean result = false;
		for (String filePath : list) {
			File file = new File(filePath);
			if (file.exists()) {
				result = file.delete();
			}
		}
		return result;
	}

	public boolean removeFile(String path) {
		// TODO Auto-generated method stub

		File file = new File(path);
		if (file.exists()) {
			return file.delete();
		}
		return false;
	}

}
