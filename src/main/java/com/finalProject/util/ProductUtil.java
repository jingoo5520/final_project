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
		} else {

		}
	}

	public void removeFile(List<String> list) {
		// TODO Auto-generated method stub
		for (String filePath : list) {
			File file = new File(filePath);
			if (file.exists()) {
				file.delete();
			}
		}
	}
}
