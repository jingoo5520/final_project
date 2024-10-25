package com.finalProject.controller.admin.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.ProductDTO;
import com.finalProject.model.ProductPagingInfoDTO;
import com.finalProject.model.ProductSearchDTO;
import com.finalProject.model.ProductUpdateDTO;
import com.finalProject.model.ProductVO;
import com.finalProject.service.admin.product.ProductService;
import com.finalProject.util.ProductUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/productmanage")
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
	public String productSave(HttpServletRequest request) {
		System.out.println(request.getSession().getServletContext().getRealPath("product"));
		return "admin/pages/productmanage/productSave";
	}

	@RequestMapping(value = "/productUpdate", method = RequestMethod.POST)
	public void productUpdate(ProductUpdateDTO updateProduct, HttpServletRequest request) {
		System.out.println(updateProduct.toString());
		List<String> subArr = new ArrayList<String>();
		ServletContext sc = request.getSession().getServletContext();
		if (ps.updateProduct(updateProduct)) {

			if (!(updateProduct.getProduct_main_image().equals("true"))) {

				String realPath = sc.getRealPath(updateProduct.getProduct_main_image());

				pu.removeFile(realPath);
			}
			if (updateProduct.getProduct_sub_image() != null) {
				for (String a : updateProduct.getProduct_sub_image()) {
					subArr.add(sc.getRealPath(a));

				}
				pu.removeFile(subArr);
			}
			// 수정 성공 메시지 반환
		}

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
//			out.println("�긽�뭹 �씠由�,媛�寃�,�븷�씤���엯");
//			out.println(productDTO.getProduct_name() + "," + productDTO.getProduct_dc_type());
//			out.flush();
//		}
//	}

	@RequestMapping(value = "/uploadProduct", method = RequestMethod.POST)
	public void UploadProduct(ProductDTO productDTO, HttpServletRequest request, HttpServletResponse response) {
		System.out.println(productDTO.toString());
		System.out.println(productDTO.getImage_main_url().getOriginalFilename());
		String url = "/resources/product";
		ServletContext sc = request.getSession().getServletContext();

		String realPath = sc.getRealPath(url);

		String fileName = "";
		String route = "";
		System.out.println(realPath);
		List<String> list = new ArrayList<>();
		pu.makeDirectory(request, realPath);

		try {
			if (productDTO.getImage_main_url().getOriginalFilename() != "") {
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

			for (MultipartFile file : productDTO.getImage_sub_url()) {
				if (file.getOriginalFilename() != "") {
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
				System.out.println("���옣 �꽦怨�");
				response.sendRedirect("/admin/productmanage/productSave");
			} else {
				pu.removeFile(list); // �떎�뙣 �떆 �뙆�씪 �궘�젣
				response.sendRedirect("/admin/productmanage/productSave");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.error("�뙆�씪 �뾽濡쒕뱶 以� �삤瑜� 諛쒖깮: {}", e.getMessage());
			pu.removeFile(list); // �삤瑜� 諛쒖깮 �떆 �뙆�씪 �궘�젣

		}
	}

	@RequestMapping("/productView")
	public String GetAllProduct(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "pagingSize", defaultValue = "10") int PagingSize) {
		ProductPagingInfoDTO dto = ProductPagingInfoDTO.builder().pageNo(pageNo).pagingSize(PagingSize).build();
		Map<String, Object> maps = new HashMap<String, Object>();
		try {
			maps = ps.getAllProducts(dto);
			model.addAttribute("productList", maps.get("list"));
			model.addAttribute("pi", maps.get("pi"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/pages/productmanage/productView";
	}

	@RequestMapping("/productSearch")
	public String getSearchProduct(ProductSearchDTO psd, Model model,
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "pagingSize", defaultValue = "10") int PagingSize) {
		ProductPagingInfoDTO dto = ProductPagingInfoDTO.builder().pageNo(pageNo).pagingSize(PagingSize).build();
		List<ProductVO> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		map.put("product_dc_type", psd.getProduct_dc_type());
		map.put("product_name", '%' + psd.getProduct_name() + '%');
		map.put("reg_date_start", psd.getReg_date_start());
		map.put("reg_date_end", psd.getReg_date_end());
		map.put("searchType", psd.getSearchType());
		System.out.println(psd.getProduct_dc_type());
		System.out.println(psd.getProduct_name());
		System.out.println(psd.getReg_date_start());
		System.out.println(psd.getReg_date_end());
		try {
			map = ps.searchProduct(map, dto);
			model.addAttribute("productList", map.get("plist"));
			model.addAttribute("pi", map.get("pi"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "admin/pages/productmanage/productView";
	}

	@RequestMapping(value = "/productDelete", method = RequestMethod.POST)
	public void DeleteProduct(int productId) {
		if (ps.deleteProduct(productId) == 1) {

		}
	}
}
