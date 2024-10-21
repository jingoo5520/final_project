package com.finalProject.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.ProductDTO;
import com.finalProject.service.ProductService;
import com.finalProject.util.ProductUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/productmanage")
public class ProductController {

	@Autowired
	private ProductService ps;
	@Autowired
	private ProductUtil pu;

//	@RequestMapping("/productView")
//	public void productList() {
//
//	}

	@RequestMapping(value = "/productSave")
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
	public void UploadProduct(ProductDTO productDTO, HttpServletRequest request, HttpServletResponse response) {
		System.out.println(productDTO.toString());
		String url = "/resources/product";
		ServletContext sc = request.getSession().getServletContext();

		String realPath = sc.getRealPath(url);

		String fileName = "";
		String route = "";
		System.out.println(realPath);
		List<String> list = new ArrayList<>();
		pu.makeDirectory(request, realPath);

		try {
			if (productDTO.getImage_main_url() != null) {
				fileName = "Main_" + UUID.randomUUID() + productDTO.getImage_main_url().getOriginalFilename();
				route = realPath + File.separator + fileName;
				File Directory = new File(realPath + File.separator + fileName);

				list.add(File.separator + fileName);
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
					list.add(File.separator + fileName);
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
				response.sendRedirect("/productmanage/productSave");
			} else {
				pu.removeFile(list); // 실패 시 파일 삭제
				response.sendRedirect("/productmanage/productSave");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.error("파일 업로드 중 오류 발생: {}", e.getMessage());
			pu.removeFile(list); // 오류 발생 시 파일 삭제

		}
	}

	@RequestMapping("/productView")
	public void GetALlProduct(Model model) {
		model.addAttribute("productList", ps.getAllProducts());
	}
}
