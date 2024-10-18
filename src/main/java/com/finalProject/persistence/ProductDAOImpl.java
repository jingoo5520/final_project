package com.finalProject.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.ProductDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {
	@Autowired
	private SqlSession ses;

	private String ns = "com.finalProject.mappers.productMapper.";

	@Override
	public int saveProduct(ProductDTO productDTO) {
		Map<String, Object> params = new HashMap<>();
		params.put("product_name", productDTO.getProduct_name());
		params.put("product_price", productDTO.getProduct_price());
		params.put("product_content", productDTO.getProduct_content());
		params.put("product_dc_type", productDTO.getProduct_dc_type());
		params.put("product_dc_amount", productDTO.getProduct_dc_amount());
		params.put("product_sell_count", productDTO.getProduct_sell_count());

		ses.insert(ns + "saveProduct", productDTO);

		return productDTO.getProduct_id();
	}

	@Override
	public int insertMainImage(String mainImage, int productId) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		params.put("mainImage", mainImage);
		params.put("product_id", productId);
		return ses.insert(ns + "saveMainImage", params);
	}

	@Override
	public int insertSubImage(List<String> subImages, int productId) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		params.put("subImage", subImages);
		params.put("product_id", productId);
		return ses.insert(ns + "saveSubImage", params);
	}
}