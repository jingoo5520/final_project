package com.finalProject.persistence.admin.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.product.ProductDTO;
import com.finalProject.model.admin.product.ProductUpdateDTO;
import com.finalProject.model.admin.product.ProductVO;

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
	public List<ProductDTO> getAllProducts(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return ses.selectList(ns + "getAllBoard", map);

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

	@Override
	public List<ProductVO> getSearchProducts(Map<String, Object> map) {

		return ses.selectList(ns + "getSearchProduct", map);
	}

	@Override
	public List<ProductDTO> getFilterProducts() {

		return ses.selectList(ns + "getFilterProduct");
	}

	@Override
	public int getTotalPostCnt() {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getCountAllProduct");
	}

	@Override
	public int getTotalSearchCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getSearchAllProduct", map);
	}

	@Override
	public int updateProductImg(ProductUpdateDTO updateProduct) {
		Map<String, Object> prams = new HashMap<>();
		prams.put("product_no", updateProduct.getProduct_no());
		prams.put("product_main_image", updateProduct.getProduct_main_image());
		prams.put("product_sub_image", updateProduct.getProduct_sub_image());
		return ses.update(ns + "deleteProductImg", prams);
	}

	@Override
	public int deleteProduct(int productId) {
		// TODO Auto-generated method stub
		return ses.delete(ns + "deleteProduct", productId);
	}
}