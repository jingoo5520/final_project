package com.finalProject.service.admin.product;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.product.ProductDTO;
import com.finalProject.model.admin.product.ProductUpdateDTO;
import com.finalProject.model.admin.product.adminCategories;
import com.finalProject.model.admin.product.adminPagingInfoDTO;

public interface ProductService {

	int saveProduct(ProductDTO productDTO, List<String> list);

	Map<String, Object> getAllProducts(adminPagingInfoDTO dto) throws Exception;

	boolean updateProduct(ProductUpdateDTO updateProduct);

	Map<String, Object> searchProduct(Map<String, Object> map, adminPagingInfoDTO dto) throws Exception;

	List<ProductDTO> getFilterProduct();

	int deleteProduct(int productId);

	void updateProductImg(int product_no, List<String> list);

	List<adminCategories> getCategories();

}
