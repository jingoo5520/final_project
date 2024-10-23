package com.finalProject.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.ProductDTO;
import com.finalProject.model.ProductUpdateDTO;

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

		return productDTO.getProduct_no();
	}

	@Override
	public int insertMainImage(String mainImage, int productId) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		params.put("mainImage", mainImage);
		params.put("product_no", productId);
		return ses.insert(ns + "saveMainImage", params);
	}

	@Override
	public int insertSubImage(List<String> subImages, int productId) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		params.put("subImage", subImages);
		params.put("product_no", productId);
		return ses.insert(ns + "saveSubImage", params);
	}

	@Override
	public List<ProductDTO> getAllProducts() {
		// TODO Auto-generated method stub
		return ses.selectList(ns + "getAllBoard");

	}

	@Override
	public int updateProduct(ProductUpdateDTO updateProduct) {
		Map<String, Object> prams = new HashMap<>();
		prams.put("product_name", updateProduct.getProduct_name());
		prams.put("product_price", updateProduct.getProduct_price());
		prams.put("product_content", updateProduct.getProduct_content());
		prams.put("product_dc_type", updateProduct.getProduct_dc_type());
		prams.put("product_dc_amount", updateProduct.getProduct_dc_amount());
		prams.put("product_sell_count", updateProduct.getProduct_sell_count());
		prams.put("product_no", updateProduct.getProduct_no());
		return ses.update(ns + "updateProduct", prams);
	}
}