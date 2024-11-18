package com.finalProject.service.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalProject.model.product.PagingInfo;
import com.finalProject.model.product.ProductDTO;
import com.finalProject.model.review.ProductDetailReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;
import com.finalProject.persistence.product.UserProductDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserProductServiceImpl implements UserProductService {

    @Autowired
    private UserProductDAO pDao; 

	@Override
	public List<ProductDTO> getProductsByPage(int page, int pageSize) throws Exception {
		int offset = (page - 1) * pageSize;
		return pDao.selectProductsByPage(offset, pageSize);
	}

	@Override
	public int getProductCount() throws Exception {
		return pDao.selectProductCount();
	}

    @Override
    public List<ProductDTO> getProductsByCategoryAndPage(Integer category, int page, int pageSize, String sortOrder) throws Exception {
        int offset = (page - 1) * pageSize;
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("offset", offset);
        params.put("limit", pageSize);
        params.put("sortOrder", sortOrder);
        return pDao.selectProductsByCategoryAndPage(params);
    }

    @Override
    public int getProductCountByCategory(Integer category) throws Exception {
    	Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        return pDao.selectProductCountByCategory(params);
    }

	@Override
	public List<ProductDTO> getProductInfo(int productId) throws Exception {
			
		return pDao.getProductById(productId);
	}

	@Override
	public ProductDTO getProductDetailById(int productId) throws Exception {
		
		return pDao.getProductDetailById(productId);
	}
	
	@Override
	public List<ProductDTO> searchProducts(String search, Integer category, PagingInfo pagingInfo, String sortOrder) throws Exception {
		return pDao.searchProducts(search, category, pagingInfo.getStartRowIndex(), pagingInfo.getPageSize(), sortOrder);
	}
	
	@Override
	public int countSearchResults(String search, Integer category) throws Exception {
		return pDao.countSearchResult(search, category);
	}

	@Override
	public List<ProductDetailReviewDTO> getReviewDetail(int productNo, int offset, int limit) throws Exception {
	    try {
	        return pDao.selectReview(productNo, offset, limit);
	    } catch (Exception e) {
	        throw new Exception("리뷰 데이터를 가져오는 중 오류 발생: " + e.getMessage());
	    }
	}

//	@Override
//	public List<String> getReviewImgs(int productNo) throws Exception {
//	    return pDao.selectReviewImg(productNo);
//	}

	@Override
	public int countReview(int productNo) throws Exception {
		return pDao.selectCountReviewProduct(productNo);
	}

}