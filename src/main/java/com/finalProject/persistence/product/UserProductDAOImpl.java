package com.finalProject.persistence.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.ProductDTO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class UserProductDAOImpl implements UserProductDAO {

	@Autowired
	   private SqlSession ses;

	   private static final String NS = "com.final_project.mappers.productMapper.";
	   
	@Override
	public List<ProductDTO> selectProductsByPage(int offset, int limit) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("limit", limit);
		List<ProductDTO> products = ses.selectList(NS + "selectProductsByPage", params);
		System.out.println("상품 반환 : " + products.size());
		return ses.selectList(NS + "selectProductsByPage", params);
	}

	@Override
	public int selectProductCount() throws Exception {
		int productCount = ses.selectOne(NS + "selectProductCount");
		System.out.println("db 에 총 상품 개수 : " + productCount);
		return ses.selectOne(NS + "selectProductCount");
	}

	@Override
	public List<ProductDTO> selectProductsByCategoryAndPage(Map<String, Object> params) throws Exception {
	    return ses.selectList(NS + "selectProductsByCategoryAndPage", params); 
	}

	@Override
	public int selectProductCountByCategory(Map<String, Object> params) throws Exception {
		return ses.selectOne(NS + "selectProductCountByCategory", params);
	}

	@Override
	public List<ProductDTO> getProductById(int productId) throws Exception {
		
		return ses.selectList(NS + "getProductById", productId);
	}

	@Override
	public ProductDTO getProductDetailById(int productId) throws Exception {
		return ses.selectOne(NS + "selectProductDetailById", productId);
	}

}
