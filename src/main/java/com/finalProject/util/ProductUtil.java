package com.finalProject.util;

import java.io.File;

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

}
