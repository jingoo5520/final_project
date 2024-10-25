package com.finalProject.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.Default;
import com.finalProject.model.ProductDTO;
import com.finalProject.service.product.ProductService;
import com.mysql.cj.result.DefaultValueFactory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/product")
public class PController {

	@Autowired
	private ProductService service;
	
	// 1. 전체 상품을 보여주는 메서드 (카테고리 없이 전체 상품 표시)
	@GetMapping("/jewelry/all")
	public String showProductList(
			@RequestParam(value = "category", required = false) Integer category,
			@RequestParam(value = "page", defaultValue = "1") int page, // 페이지 켰을때 1페이지 고정
            @RequestParam(value = "pageSize", defaultValue = "18") int pageSize, // 한 페이지에서 보여줄 상품 개수
            @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
			Model model ) throws Exception {
		
		List<ProductDTO> products = service.getProductsByPage(page, pageSize);  // 전체 상품 가져오기
		

        int totalProducts = service.getProductCount();  // 전체 상품 수 계산
        
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        
	     // 한 번에 보여줄 페이지 범위 설정 (예: 10페이지씩)
        int pageBlockSize = 10;
        int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
        int startPage = (currentBlock - 1) * pageBlockSize + 1;
        int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);
        int totalProductCount = service.getProductCount();

        // Model에 데이터 추가
        model.addAttribute("totalProductCount", totalProductCount);
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasPrevBlock", currentBlock > 1);
        model.addAttribute("hasNextBlock", endPage < totalPages);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("sortOrder", sortOrder);  // 정렬 기준 추가
        model.addAttribute("category", category);  // 카테고리 추가
        model.addAttribute("totalProducts", totalProducts);
        
        
        // 각 카테고리별 상품 개수 전달
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);
        
        // 카테고리별 상품 개수 전달
        model.addAttribute("necklaceCount", necklaceCount);
        model.addAttribute("earringCount", earringCount);
        model.addAttribute("piercingCount", piercingCount);
        model.addAttribute("bangleCount", bangleCount);
        model.addAttribute("ankletCount", ankletCount);
        model.addAttribute("ringCount", ringCount);
        model.addAttribute("couplingCount", couplingCount);
        model.addAttribute("pendantCount", pendantCount);
        model.addAttribute("otherCount", otherCount);
		
		return "/user/pages/product/productList"; // jsp
	}
	
	// 2. 카테고리별로 상품을 보여주는 메서드
    @GetMapping("/jewelry")
    public String showProductList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "18") int pageSize,
            @RequestParam(value = "category", required = false) Integer category,
            @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
            Model model) throws Exception {

    	System.out.println("카테고리 값 : " + category); 
    	sortOrder = sortOrder.trim();

        List<ProductDTO> products = service.getProductsByCategoryAndPage(category, page, pageSize, sortOrder);
        
        int totalProducts = service.getProductCountByCategory(category);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        int totalProductCount = service.getProductCount();
        
        System.out.println(totalProducts);
        System.out.println("Received sortOrder: '" + sortOrder + "'");

        // 페이지네이션
        int pageBlockSize = 10;
        int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
        int startPage = (currentBlock - 1) * pageBlockSize + 1;
        int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);
        
        // 각 카테고리별 상품 개수 가져오기
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);
        
        // 카테고리별 상품 개수 전달
        model.addAttribute("necklaceCount", necklaceCount);
        model.addAttribute("earringCount", earringCount);
        model.addAttribute("piercingCount", piercingCount);
        model.addAttribute("bangleCount", bangleCount);
        model.addAttribute("ankletCount", ankletCount);
        model.addAttribute("ringCount", ringCount);
        model.addAttribute("couplingCount", couplingCount);
        model.addAttribute("pendantCount", pendantCount);
        model.addAttribute("otherCount", otherCount);

        // Model에 데이터 추가
        model.addAttribute("totalProductCount", totalProductCount);
        model.addAttribute("sortOrder", sortOrder);
        model.addAttribute("category", category);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasPrevBlock", currentBlock > 1);
        model.addAttribute("hasNextBlock", endPage < totalPages);
        

        return "/user/pages/product/productList";  // JSP 파일
    }
    
    @GetMapping ("/jewelry/detail")
    public String showProductDetail (
    		@RequestParam("productNo") int productId,
    		Model model) throws Exception {
    	
    	// 상품 정보
    	List<ProductDTO> products = service.getProductInfo(productId);
    	
    	// content 가져오는 
    	ProductDTO product = service.getProductDetailById(productId);
    	
    	// 리뷰정보
    	
    	
    	model.addAttribute("products", products);
    	model.addAttribute("product_content", product.getProduct_content());
    	model.addAttribute("calculatedPrice", product.getCalculatedPrice());  // 계산된 가격 추가
    	return "/user/pages/product/productDetail";
    }
   
    
	

}
