package com.finalProject.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.ProductDTO;
import com.finalProject.service.ProductService;
import com.finalProject.util.ProductUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductController {

	@Autowired
	private ProductService ps;
	@Autowired
	private ProductUtil pu;

	@RequestMapping("/productSave")
	public String productSave() {
		return "productmanage/productSave";
	}
//
//	@RequestMapping("/test")
//	public void home() {
//
//	}
//
//	@RequestMapping(value = "/file", method = RequestMethod.POST)
//	public void MultipartFile(MultipartFile multipartFile) {
//
//	}
//
//	@PostMapping("/makeCsv")
//	public void downloadCSV(ProductDTO productDTO, String fileName, HttpServletResponse response) throws IOException {
//
//		response.setContentType("text/csv charset=MS949");
//		response.setHeader("Content-Disposition",
//				"attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
//
//		try (PrintWriter out = new PrintWriter(new OutputStreamWriter(response.getOutputStream(), "MS949"))) {
//			out.println("상품 이름,가격,할인타입");
//			out.println(productDTO.getProduct_name() + "," + productDTO.getProduct_dc_type());
//			out.flush();
//		}
//	}

	@RequestMapping(value = "/uploadProduct", method = RequestMethod.POST)
	public void UploadProduct(ProductDTO productDTO, HttpServletRequest request) {
		System.out.println(productDTO.toString());
		String url = "/Product";
		String realPath = request.getSession().getServletContext().getRealPath(url);
		String fileName = "";
		String route = "";
		System.out.println(realPath);
		List<String> list = new ArrayList<>();
		pu.makeDirectory(request, realPath);

		if (productDTO.getImage_main_url() != null) {
			fileName = "Main_" + UUID.randomUUID() + productDTO.getImage_main_url().getOriginalFilename();
			route = realPath + File.separator + fileName;
			File Directory = new File(realPath + File.separator + fileName);

			list.add(route);
			try {
				productDTO.getImage_main_url().transferTo(Directory);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (productDTO.getImage_sub_url() != null) {
			for (MultipartFile file : productDTO.getImage_sub_url()) {
				fileName = "Sub_" + UUID.randomUUID() + file.getOriginalFilename();
				route = realPath + File.separator + fileName;

				File Directory = new File(realPath + File.separator + fileName);
				list.add(route);
				try {
					file.transferTo(Directory);
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		if (ps.saveProduct(productDTO, list) == 1) {
			System.out.println("저장 성공");
		}

	}
}
