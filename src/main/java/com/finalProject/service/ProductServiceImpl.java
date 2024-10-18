package com.finalProject.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.ProductDTO;
import com.finalProject.persistence.ProductDAO;

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

}
