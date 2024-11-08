package com.finalProject.service.admin.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.admin.product.PagingInfo;
import com.finalProject.model.admin.product.ProductDTO;
import com.finalProject.model.admin.product.ProductUpdateDTO;
import com.finalProject.model.admin.product.ProductVO;
import com.finalProject.model.admin.product.adminCategories;
import com.finalProject.model.admin.product.adminPagingInfoDTO;
import com.finalProject.persistence.admin.product.ProductDAO;
import com.finalProject.util.ProductUtil;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductUtil pu;
	@Autowired
	private ProductDAO pDAO;

	@Override
	@Transactional(isolation = Isolation.DEFAULT, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public int saveProduct(ProductDTO productDTO, List<String> list, String realPath) {
		String mainImage = null;
		List<String> subImages = new ArrayList<>();
		String fileName = "";
		int result = 0;
		System.out.println(productDTO);
		if (productDTO.getProduct_content_file().getOriginalFilename() != "") {
			try {

				fileName = "Content_" + UUID.randomUUID() + productDTO.getProduct_content_file().getOriginalFilename();
				File Directory = new File(realPath + File.separator + fileName);
				productDTO.getProduct_content_file().transferTo(Directory);
			} catch (Exception e) {
				pu.removeFile(realPath);
				e.printStackTrace();
			}
			productDTO.setProduct_content(fileName);
		}
		int productId = pDAO.saveProduct(productDTO);
		System.out.println(productId);
		for (String imageUrl : list) {
			if (imageUrl.contains("Main_")) {
				mainImage = imageUrl; // "main"?�� ?��?��?�� ?��미�??�� 메인 ?��미�?�? 처리
			} else if (imageUrl.contains("Sub_")) {
				subImages.add(imageUrl); // "sub"?�� ?��?��?�� ?��미�??�� ?���? ?��미�?�? 처리
			}
		}
		if (mainImage != null) {
			result = pDAO.insertMainImage(mainImage, productId);

		}
		if (!subImages.isEmpty()) {
			result = pDAO.insertSubImage(subImages, productId);
		}

		return result;
	}

	@Override

	public Map<String, Object> getAllProducts(adminPagingInfoDTO dto) throws Exception {
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		PagingInfo pi = makePagingInfo(dto);
		map.put("startRowIndex", pi.getStartRowIndex());
		map.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
		resultMap.put("list", pDAO.getAllProducts(map));
		resultMap.put("pi", pi);
		return resultMap;
	}

	public boolean updateProductMSImage(ProductUpdateDTO updateProduct) {
		// boolean 선언
		boolean resultProductInfo = false;
		boolean resultProductImg = false;
		// 메인 이미지 경로 처리 (비어있는 경우 예외 처리 추가)
		String mainImage = updateProduct.getProduct_main_image();
		if (mainImage != null && !mainImage.trim().isEmpty()) {
			updateProduct.setProduct_main_image(mainImage.trim().replace("/resources/product/", ""));
		} else {
			updateProduct.setProduct_main_image(null); // 메인 이미지가 없으면 null로 처리
		}

		// 서브 이미지 경로 처리 (서브 이미지가 있을 경우에만 처리)
		if (updateProduct.getProduct_sub_image() != null) {
			for (int i = 0; i < updateProduct.getProduct_sub_image().size(); i++) {
				String subImage = updateProduct.getProduct_sub_image().get(i);
				if (subImage != null && !subImage.trim().isEmpty()) {
					updateProduct.getProduct_sub_image().set(i, subImage.trim().replace("/resources/product/", ""));
				}
			}
		} else {
			updateProduct.setProduct_content(null);
		}
		// 상품 업데이트 처리
		if (pDAO.updateProduct(updateProduct) >= 1) {
			// 이미지 정보 업데이트
			resultProductInfo = true;
		}
		if (pDAO.updateProductImg(updateProduct) >= 1) {
			resultProductImg = true;
		}

		if (resultProductInfo || resultProductImg) {
			return true;
		} else {
			return false;
		}

	}

	@Override
	public Map<String, Object> searchProduct(Map<String, Object> map, adminPagingInfoDTO dto) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<>();

		PagingInfo pi = makePagingInfo(dto, map);
		resultMap.put("pi", pi);
		map.put("startRowIndex", pi.getStartRowIndex());
		map.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
		List<ProductVO> plist = pDAO.getSearchProducts(map);

		resultMap.put("plist", plist);

		return resultMap;
	}

	private PagingInfo makePagingInfo(adminPagingInfoDTO dto, Map<String, Object> map) {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(pDAO.getTotalSearchCnt(map));

		pi.setTotalPageCnt(); // ?���? ?��?���? ?�� ?��?��
		pi.setStartRowIndex(); // ?��?�� ?��?���??��?�� 보여주기 ?��?��?�� �??�� index번호

		// ?��?���? 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		System.out.println(pi.toString());
		return pi;
	}

	@Override
	public List<ProductDTO> getFilterProduct() {
		List<ProductDTO> plist = pDAO.getFilterProducts();

		return plist;
	}

	private PagingInfo makePagingInfo(adminPagingInfoDTO dto) throws Exception {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(pDAO.getTotalPostCnt());

		pi.setTotalPageCnt(); // ?���? ?��?���? ?�� ?��?��
		pi.setStartRowIndex(); // ?��?�� ?��?���??��?�� 보여주기 ?��?��?�� �??�� index번호

		// ?��?���? 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBlock();
		pi.setEndPageNoCurBlock();

		System.out.println(pi.toString());
		return pi;
	}

	@Override
	public int deleteProduct(int productId) {
		// TODO Auto-generated method stub
		return pDAO.deleteProduct(productId);
	}

	public void updateProductImg(int product_no, List<String> list, String contentText) {
		String mainImage = null;
		String content = contentText;
		List<String> subImages = new ArrayList<>();

		for (String imageUrl : list) {
			if (imageUrl.contains("Main_")) {
				mainImage = imageUrl; // "main"이 포함된 이미지는 메인 이미지로 처리
			} else if (imageUrl.contains("Sub_")) {
				subImages.add(imageUrl); // "sub"이 포함된 이미지는 서브 이미지로 처리
			}

		}
		if (mainImage != null) {
			pDAO.insertMainImage(mainImage, product_no);
			System.out.println(mainImage);
		}
		if (!subImages.isEmpty()) {
			pDAO.insertSubImage(subImages, product_no);
			System.out.println(subImages.toArray().toString());
		}
		if (content != null && content != "") {
			pDAO.updateContent(product_no, content);
		}
	}

	@Override
	public List<adminCategories> getCategories() {

		return pDAO.getCategories();
	}

	@Override
	@Transactional(rollbackFor = Exception.class, isolation = Isolation.DEFAULT)
	public ResponseEntity<String> updateFile(ProductUpdateDTO updateProduct, HttpServletRequest request) {
		if (updateProduct.getDc_rate() != 0) {
			updateProduct.setDc_rate(updateProduct.getDc_rate() / 100);
		}
		String contentPath = "";
		System.out.println(updateProduct.toString());
		List<String> subArr = new ArrayList<>();
		List<String> list = new ArrayList<>();

		ServletContext sc = request.getSession().getServletContext();
		String path = sc.getRealPath("/resources/product");
		if (!"true".equals(updateProduct.getProduct_content()) && updateProduct.getProduct_content() != "") {
			updateProduct
					.setProduct_content(updateProduct.getProduct_content().trim().replace("/resources/product/", ""));
			System.out.println(updateProduct.getProduct_content());
			pDAO.deleteContentImg(updateProduct.getProduct_no(), updateProduct.getProduct_content());
			String removeContent = sc
					.getRealPath("resources/product" + File.separator + updateProduct.getProduct_content());
			pu.removeFile(removeContent);
			System.out.println("컨텐트이미지 이미지 삭제 경로: " + updateProduct.getProduct_content());

		}
		// 콘텐츠 이미지 저장
		if (updateProduct.getContent_image() != null && !updateProduct.getContent_image().isEmpty()) {
			contentPath = "Content_" + UUID.randomUUID() + updateProduct.getContent_image().getOriginalFilename();
			File contentFile = new File(path + File.separator + contentPath);
			try {
				updateProduct.getContent_image().transferTo(contentFile);
				System.out.println(updateProduct.getContent_image().getOriginalFilename());
				int result = pDAO.updateContent(updateProduct.getProduct_no(), contentPath);
				System.out.println(result);

			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("updateFail");
			}

		}

		// 메인 이미지 저장
		if (updateProduct.getImage_main_url() != null && !updateProduct.getImage_main_url().isEmpty()) {
			String mainFileName = "Main_" + UUID.randomUUID() + updateProduct.getImage_main_url().getOriginalFilename();
			File mainFile = new File(path + File.separator + mainFileName);
			list.add(mainFileName);
			try {
				updateProduct.getImage_main_url().transferTo(mainFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("updateFail");
			}
		}

		// 서브 이미지 저장
		if (updateProduct.getImage_sub_url() != null) {
			for (MultipartFile file : updateProduct.getImage_sub_url()) {
				if (!file.isEmpty()) {
					String subFileName = "Sub_" + UUID.randomUUID() + file.getOriginalFilename();
					File subFile = new File(path + File.separator + subFileName);
					list.add(subFileName);
					try {
						file.transferTo(subFile);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
						return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("updateFail");
					}
				}
			}
		}

		// DB 업데이트 로직 실행
		if (updateProductMSImage(updateProduct)) {
			System.out.println("DB 업데이트 완료 후 파일 삭제 실행");
			// 메인 이미지 삭제
			if (!"true".equals(updateProduct.getProduct_main_image())) {
				System.out.println(updateProduct.getProduct_main_image());
				String mainImagePath = sc
						.getRealPath("resources/product" + File.separator + updateProduct.getProduct_main_image());
				pu.removeFile(mainImagePath);
				System.out.println("메인 이미지 삭제 경로: " + mainImagePath);
			}

			// 서브 이미지 삭제
			if (updateProduct.getProduct_sub_image() != null) {
				for (String subImage : updateProduct.getProduct_sub_image()) {
					String subImagePath = sc.getRealPath("resources/product" + File.separator + subImage);
					subArr.add(subImagePath);
					System.out.println("서브 이미지 삭제 경로: " + subImagePath);
				}
				pu.removeFile(subArr);
			}

		}

		// 이미지 업데이트 후 DB에 반영
		if (!list.isEmpty()) {
			updateProductImg(updateProduct.getProduct_no(), list, contentPath);
		}

		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
}
