package com.finalProject.persistence.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.product.PagingInfo;
import com.finalProject.model.product.ProductDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class UserProductDAOImpl implements UserProductDAO {

	@Autowired
	   private SqlSession ses;

	   private static String ns = "com.finalProject.mappers.productMapper.";
	   
	@Override
	public List<ProductDTO> selectProductsByPage(int offset, int limit) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("limit", limit);
		List<ProductDTO> products = ses.selectList(ns + "selectProductsByPage", params);
		System.out.println("�긽�뭹 諛섑솚 : " + products.size());
		return ses.selectList(ns + "selectProductsByPage", params);
	}

	@Override
	public int selectProductCount() throws Exception {
		int productCount = ses.selectOne(ns + "selectProductCount");
		System.out.println("db �뿉 珥� �긽�뭹 媛쒖닔 : " + productCount);
		return ses.selectOne(ns + "selectProductCount");
	}

	@Override
	public List<ProductDTO> selectProductsByCategoryAndPage(Map<String, Object> params) throws Exception {
	    return ses.selectList(ns + "selectProductsByCategoryAndPage", params); 
	}

	@Override
	public int selectProductCountByCategory(Map<String, Object> params) throws Exception {
		return ses.selectOne(ns + "selectProductCountByCategory", params);
	}

	@Override
	public List<ProductDTO> getProductById(int productId) throws Exception {
		
		return ses.selectList(ns + "getProductById", productId);
	}

	@Override
	public ProductDTO getProductDetailById(int productId) throws Exception {
		return ses.selectOne(ns + "selectProductDetailById", productId);
	}
	
	@Override
	public int countSearchResult(String search, Integer category) throws Exception {
		Map<String, Object> params = new HashMap<>();
	    params.put("search", search);
	    params.put("category", category);
	    
		return ses.selectOne(ns + "countSearchResults", params);
	}

	@Override
	public List<ProductDTO> searchProducts(String search, Integer category, int offset, int limit, String sortOrder) {
		
	    Map<String, Object> params = new HashMap<>();
	    params.put("search", search);
	    params.put("category", category);
	    params.put("offset", offset);
	    params.put("limit", limit);
	    params.put("sortOrder", sortOrder);
	    
		return ses.selectList(ns + "searchProducts" , params);
	}

}