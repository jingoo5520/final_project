package com.finalProject.service.admin.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.product.PagingInfo;
import com.finalProject.model.admin.product.ProductDTO;
import com.finalProject.model.admin.product.ProductPagingInfoDTO;
import com.finalProject.model.admin.product.ProductUpdateDTO;
import com.finalProject.model.admin.product.ProductVO;
import com.finalProject.persistence.admin.product.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDAO pDAO;

	@Override
	@Transactional(isolation = Isolation.DEFAULT, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public int saveProduct(ProductDTO productDTO, List<String> list) {
		String mainImage = null;
		List<String> subImages = new ArrayList<>();
		int result = 0;
		int productId = pDAO.saveProduct(productDTO);
		System.out.println(productId);
		for (String imageUrl : list) {
			if (imageUrl.contains("Main_")) {
				mainImage = imageUrl; // "main"이 포함된 이미지는 메인 이미지로 처리
			} else if (imageUrl.contains("Sub_")) {
				subImages.add(imageUrl); // "sub"이 포함된 이미지는 서브 이미지로 처리
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

	public Map<String, Object> getAllProducts(ProductPagingInfoDTO dto) throws Exception {
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		PagingInfo pi = makePagingInfo(dto);
		map.put("startRowIndex", pi.getStartRowIndex());
		map.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
		resultMap.put("list", pDAO.getAllProducts(map));
		resultMap.put("pi", pi);
		return resultMap;
	}

	@Override
	@Transactional(rollbackFor = Exception.class, isolation = Isolation.DEFAULT, propagation = Propagation.REQUIRED)
	public boolean updateProduct(ProductUpdateDTO updateProduct) {
		if (pDAO.updateProduct(updateProduct) == 1) {

			updateProduct
					.setProduct_main_image(updateProduct.getProduct_main_image().replace("/resources/product", ""));
			for (int i = 0; i < updateProduct.getProduct_sub_image().size(); i++) {

				String updatedImage = updateProduct.getProduct_sub_image().get(i).replace("/resources/product", "");
				updateProduct.getProduct_sub_image().set(i, updatedImage);
			}
			if (pDAO.updateProductImg(updateProduct) == 1) {
				return true;
			}
		}

		return false;
	}

	@Override
	public Map<String, Object> searchProduct(Map<String, Object> map, ProductPagingInfoDTO dto) throws Exception {
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

	private PagingInfo makePagingInfo(ProductPagingInfoDTO dto, Map<String, Object> map) {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(pDAO.getTotalSearchCnt(map));

		pi.setTotalPageCnt(); // 전체 페이지 수 세팅
		pi.setStartRowIndex(); // 현재 페이지에서 보여주기 시작할 글의 index번호

		// 페이징 블럭
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

	private PagingInfo makePagingInfo(ProductPagingInfoDTO dto) throws Exception {
		PagingInfo pi = new PagingInfo(dto);
		pi.setTotalPostCnt(pDAO.getTotalPostCnt());

		pi.setTotalPageCnt(); // 전체 페이지 수 세팅
		pi.setStartRowIndex(); // 현재 페이지에서 보여주기 시작할 글의 index번호

		// 페이징 블럭
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
}
