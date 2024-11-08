package com.finalProject.persistence.admin.product;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.product.ProductDTO;
import com.finalProject.model.admin.product.ProductUpdateDTO;
import com.finalProject.model.admin.product.ProductVO;
import com.finalProject.model.admin.product.adminCategories;

public interface ProductDAO {

	int saveProduct(ProductDTO productDTO);

	int insertMainImage(String mainImage, int productId);

	int insertSubImage(List<String> subImages, int productId);

	List<ProductDTO> getAllProducts(Map<String, Object> map);

	int updateProduct(ProductUpdateDTO updateProduct);

	List<ProductVO> getSearchProducts(Map<String, Object> map);

	List<ProductDTO> getFilterProducts();

	int getTotalPostCnt();

	int getTotalSearchCnt(Map<String, Object> map);

	int updateProductImg(ProductUpdateDTO updateProduct);

	int deleteProduct(int productId);

	List<adminCategories> getCategories();

	int updateContent(int product_no, String content);

	void deleteContentImg(int i, String product_content);

}
