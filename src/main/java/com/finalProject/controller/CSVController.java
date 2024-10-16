package com.finalProject.controller;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.CSVDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CSVController {
	@RequestMapping("/csv")
	public void csv() {

	}

	@RequestMapping("/test")
	public void home() {

	}

	@RequestMapping(value = "/file", method = RequestMethod.POST)
	public void MultipartFile(MultipartFile multipartFile) {

	}

	@PostMapping("/makeCsv")
	public void downloadCSV(CSVDTO csvDTO, String fileName, HttpServletResponse response) throws IOException {

		response.setContentType("text/csv charset=MS949");
		response.setHeader("Content-Disposition",
				"attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");

		try (PrintWriter out = new PrintWriter(new OutputStreamWriter(response.getOutputStream(), "MS949"))) {
			out.println("상품 이름,가격,할인타입");
			out.println(csvDTO.getName() + "," + csvDTO.getCnt() + "," + csvDTO.getDcType());
			out.flush();
		}
	}

}
