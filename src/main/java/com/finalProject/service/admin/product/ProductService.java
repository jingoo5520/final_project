package com.finalProject.service.admin.product;

import java.util.List;
import java.util.Map;

import com.finalProject.model.ProductDTO;
import com.finalProject.model.ProductPagingInfoDTO;
import com.finalProject.model.ProductUpdateDTO;

public interface ProductService {

	int saveProduct(ProductDTO productDTO, List<String> list);

	Map<String, Object> getAllProducts(ProductPagingInfoDTO dto) throws Exception;

	boolean updateProduct(ProductUpdateDTO updateProduct);

	Map<String, Object> searchProduct(Map<String, Object> map, ProductPagingInfoDTO dto) throws Exception;

	List<ProductDTO> getFilterProduct();

	int deleteProduct(int productId);

}
