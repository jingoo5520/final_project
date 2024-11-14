package com.finalProject.service.admin.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;

import com.finalProject.model.admin.product.ProductDTO;
import com.finalProject.model.admin.product.ProductUpdateDTO;
import com.finalProject.model.admin.product.adminCategories;
import com.finalProject.model.admin.product.adminPagingInfoDTO;

public interface ProductService {

	int saveProduct(ProductDTO productDTO, List<String> list, String realPath);

	Map<String, Object> getAllProducts(adminPagingInfoDTO dto) throws Exception;

	Map<String, Object> searchProduct(Map<String, Object> map, adminPagingInfoDTO dto) throws Exception;

	List<ProductDTO> getFilterProduct();

	int deleteProduct(int productId);

	List<adminCategories> getCategories();

	ResponseEntity<String> updateFile(ProductUpdateDTO updateProduct, HttpServletRequest request);

}
