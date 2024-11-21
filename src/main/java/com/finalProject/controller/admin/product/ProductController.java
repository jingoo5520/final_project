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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.admin.product.ProductDTO;
import com.finalProject.model.admin.product.ProductSearchDTO;
import com.finalProject.model.admin.product.ProductUpdateDTO;
import com.finalProject.model.admin.product.ProductVO;
import com.finalProject.model.admin.product.adminCategories;
import com.finalProject.model.admin.product.adminPagingInfoDTO;
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
	public String productSave(HttpServletRequest request, Model model) {
		System.out.println(request.getSession().getServletContext().getRealPath("product"));
		List<adminCategories> list = new ArrayList<adminCategories>();

		list = ps.getCategories();

		model.addAttribute("categories", list);
		return "admin/pages/productmanage/productSave";
	}

	@RequestMapping(value = "/productUpdate", method = RequestMethod.POST)
	public ResponseEntity<String> productUpdate(@ModelAttribute ProductUpdateDTO updateProduct,
			HttpServletRequest request) {
		System.out.println("sdsdsddsds");
		return ps.updateFile(updateProduct, request);

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
		pu.makeDirectory(realPath);

		try {
			if (productDTO.getImage_main_url().getOriginalFilename() != "") {
				fileName = "Main_" + UUID.randomUUID() + productDTO.getImage_main_url().getOriginalFilename();
				route = realPath + File.separator + fileName;
				File Directory = new File(realPath + File.separator + fileName);

				list.add(fileName);
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
					list.add(fileName);
					try {
						file.transferTo(Directory);
					} catch (IllegalStateException | IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			productDTO.setDc_rate(productDTO.getDc_rate() / 100);
			if (ps.saveProduct(productDTO, list, realPath) == 1) {
				System.out.println("占쏙옙占쎌삢 占쎄쉐�⑨옙");
				response.sendRedirect("/admin/productmanage/productSave");
			} else {
				pu.removeFile(list); // 占쎈뼄占쎈솭 占쎈뻻 占쎈솁占쎌뵬 占쎄텣占쎌젫
				response.sendRedirect("/admin/productmanage/productSave");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.error("占쎈솁占쎌뵬 占쎈씜嚥≪뮆諭� 餓ο옙 占쎌궎�몴占� 獄쏆뮇源�: {}", e.getMessage());
			pu.removeFile(list); // 占쎌궎�몴占� 獄쏆뮇源� 占쎈뻻 占쎈솁占쎌뵬 占쎄텣占쎌젫

		}
	}

	@RequestMapping("/productView")
	public String GetAllProduct(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "pagingSize", defaultValue = "10") int PagingSize) {
		adminPagingInfoDTO dto = adminPagingInfoDTO.builder().pageNo(pageNo).pagingSize(PagingSize).build();
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
		adminPagingInfoDTO dto = adminPagingInfoDTO.builder().pageNo(pageNo).pagingSize(PagingSize).build();
		List<ProductVO> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		map.put("product_dc_type", psd.getProduct_dc_type());
		map.put("product_name", '%' + psd.getProduct_name() + '%');
		map.put("reg_date_start", psd.getReg_date_start());
		if (psd.getReg_date_end() != null && psd.getReg_date_end() != "") {
			map.put("reg_date_end", psd.getReg_date_end() + " 23:59:59");
		} else {
			map.put("reg_date_end", psd.getReg_date_end());
		}

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
	public ResponseEntity<Map<String, Object>> DeleteProduct(int productId) {
		Map<String, Object> map = new HashMap<String, Object>();

		if (ps.deleteProduct(productId) == 1) {
			map.put("status", "success");
			return ResponseEntity.ok(map);
		} else {
			map.put("status", "fail");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(map);
		}
	}
}
