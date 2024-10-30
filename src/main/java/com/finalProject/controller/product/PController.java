package com.finalProject.controller.product;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.finalProject.model.product.PagingInfo;
import com.finalProject.model.product.PagingInfoDTO;
import com.finalProject.model.product.ProductDTO;
import com.finalProject.service.product.UserProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/product")
public class PController {

    @Autowired
    private UserProductService service;

    // 1. 占쏙옙체 占쏙옙품占쏙옙 占쏙옙占쏙옙占쌍댐옙 占쌨쇽옙占쏙옙 (카占쌓곤옙 占쏙옙占쏙옙 占쏙옙체 占쏙옙품 표占쏙옙)
    @GetMapping("/jewelry/all")
    public String showProductList(
            @RequestParam(value = "category", required = false) Integer category,
            @RequestParam(value = "page", defaultValue = "1") int page, // 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙트 占쏙옙 占쏙옙占쏙옙
            @RequestParam(value = "pageSize", defaultValue = "6") int pageSize, // 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙품 占쏙옙占쏙옙
            @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
            Model model) throws Exception {

        List<ProductDTO> products = service.getProductsByPage(page, pageSize);  // 占쏙옙체 占쏙옙품 占쏙옙회
        
        
        // 占쏙옙체 占쏙옙품 占쏙옙占쏙옙 占쏙옙占�
        int totalProducts = service.getProductCount();  
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // 占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占� 占쏙옙占쏙옙 (占쏙옙: 10占쏙옙占쏙옙占쏙옙占쏙옙)
        int pageBlockSize = 10;
        int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
        int startPage = (currentBlock - 1) * pageBlockSize + 1;
        int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);
        int totalProductCount = service.getProductCount();

        // Model占쏙옙 占쏙옙占쏙옙占쏙옙 占쌩곤옙
        model.addAttribute("totalProductCount", totalProductCount);
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasPrevBlock", currentBlock > 1);
        model.addAttribute("hasNextBlock", endPage < totalPages);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("sortOrder", sortOrder);  // 占쏙옙占쏙옙 占쏙옙占쏙옙 占쌩곤옙
        model.addAttribute("category", category);  // 카占쌓곤옙 占쌩곤옙
        model.addAttribute("totalProducts", totalProducts);
        System.out.println("all : " + totalProducts);
        
        // 占쏙옙 카占쌓곤옙占쏙옙占쏙옙 占쏙옙품 占쏙옙占쏙옙 占쏙옙占쏙옙
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);
        // 카占쌓곤옙占쏙옙占쏙옙 占쏙옙품 占쏙옙占쏙옙 占쏙옙占쏙옙
        model.addAttribute("necklaceCount", necklaceCount);
        model.addAttribute("earringCount", earringCount);
        model.addAttribute("piercingCount", piercingCount);
        model.addAttribute("bangleCount", bangleCount);
        model.addAttribute("ankletCount", ankletCount);
        model.addAttribute("ringCount", ringCount);
        model.addAttribute("couplingCount", couplingCount);
        model.addAttribute("pendantCount", pendantCount);
        model.addAttribute("otherCount", otherCount);

        return "/user/pages/product/productList"; // jsp 占쏙옙占쏙옙 占쏙옙환
    }

    // 2. 카占쌓곤옙占쏙옙占쏙옙 占쏙옙품占쏙옙 占쏙옙占쏙옙占쌍댐옙 占쌨쇽옙占쏙옙
    @GetMapping("/jewelry")
    public String showProductList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "6") int pageSize,
            @RequestParam(value = "category", required = false) Integer category,
            @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
            Model model) throws Exception {

        System.out.println("카占쌓곤옙占쏙옙 占쏙옙 : " + category);
        sortOrder = sortOrder.trim();

        List<ProductDTO> products = service.getProductsByCategoryAndPage(category, page, pageSize, sortOrder);

        int totalProducts = service.getProductCountByCategory(category);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        int totalProductCount = service.getProductCount();

        System.out.println("占쏙옙체 占쏙옙품 占쏙옙: " + totalProducts);
        System.out.println("Received sortOrder: '" + sortOrder + "'");

        // 占쏙옙占쏙옙占쏙옙占쏙옙占싱쇽옙 占쏙옙占쏙옙
        int pageBlockSize = 10;
        int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
        int startPage = (currentBlock - 1) * pageBlockSize + 1;
        int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);

        // 占쏙옙 카占쌓곤옙占쏙옙 占쏙옙품 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);
        // 카占쌓곤옙占쏙옙占쏙옙 占쏙옙품 占쏙옙占쏙옙 占쏙옙占쏙옙
        model.addAttribute("necklaceCount", necklaceCount);
        model.addAttribute("earringCount", earringCount);
        model.addAttribute("piercingCount", piercingCount);
        model.addAttribute("bangleCount", bangleCount);
        model.addAttribute("ankletCount", ankletCount);
        model.addAttribute("ringCount", ringCount);
        model.addAttribute("couplingCount", couplingCount);
        model.addAttribute("pendantCount", pendantCount);
        model.addAttribute("otherCount", otherCount);

        // Model占쏙옙 占쏙옙占쏙옙占쏙옙 占쌩곤옙
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
        


        System.out.println("카占쌓곤옙占쏙옙 : " + totalProducts);
        return "/user/pages/product/productList";  // JSP 占쏙옙占쏙옙 占쏙옙환
    }

    // 3. 占쏙옙품 占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쌍댐옙 占쌨쇽옙占쏙옙
    @GetMapping("/jewelry/detail")
    public String showProductDetail(
            @RequestParam("productNo") int productId,
            Model model) throws Exception {

        // 占쏙옙품 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
        List<ProductDTO> products = service.getProductInfo(productId);

        // 占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
        ProductDTO product = service.getProductDetailById(productId);

        // Model占쏙옙 占쏙옙占쏙옙占쏙옙 占쌩곤옙
        model.addAttribute("products", products);
        model.addAttribute("product_content", product.getProduct_content());
        model.addAttribute("calculatedPrice", product.getCalculatedPrice());  // 占쏙옙占쏙옙 占쏙옙占쏙옙 占쌩곤옙
        return "/user/pages/product/productDetail";
    }
    
    // 4. 占싯삼옙占쏙옙占�
    @GetMapping("/jewelry/result")
    public String search (
    		@RequestParam(required = false) String search, // 占싯삼옙占쏙옙
	        @RequestParam(required = false) Integer category, // 카占쌓곤옙占쏙옙 (占쏙옙占쏙옙)
	        @RequestParam(defaultValue = "1") int page, // 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙호
	        @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
    		Model model) throws Exception {
    	
    	System.out.println("占싯삼옙占싯삼옙 : search=" + search + ", category=" + category + 
                ", page=" + page + ", sortOrder=" + sortOrder);
    	

    	
        // 1. 占쏙옙 占쌉시뱄옙 占쏙옙 占쏙옙회
        int totalPostCnt = service.countSearchResults(search, category);
        
        // 2. 占쏙옙占쏙옙징 占쏙옙占쏙옙 占쏙옙占쏙옙
        PagingInfoDTO pagingInfoDTO = new PagingInfoDTO(page, 9); // 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 9占쏙옙占쏙옙 占쏙옙회
        PagingInfo pagingInfo = new PagingInfo(pagingInfoDTO, totalPostCnt);

        // 3. 占싯삼옙 占쏙옙占� 占쏙옙회
        List<ProductDTO> searchResults = service.searchProducts(search, category, pagingInfo, sortOrder);
        System.out.println("占쏙옙占쏙옙占쏙옙");
        System.out.println(searchResults);
        
        
        // 4. 占쏜델울옙 占싯삼옙 占쏙옙占� 占쏙옙 占쏙옙占쏙옙징 占쏙옙占쏙옙 占쏙옙占�
        model.addAttribute("products", searchResults);
        model.addAttribute("pagingInfo", pagingInfo);
        model.addAttribute("search", search);
        model.addAttribute("category", category);
        model.addAttribute("sortOrder", sortOrder);
        model.addAttribute("searchProductCount", totalPostCnt);
        model.addAttribute("startPage", pagingInfo.getStartPage()); // 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌩곤옙
        model.addAttribute("endPage", pagingInfo.getEndPage()); // 占쏙옙 占쏙옙占쏙옙占쏙옙 占쌩곤옙
        model.addAttribute("totalPages", pagingInfo.getTotalPages()); // 占쏙옙체 占쏙옙占쏙옙占쏙옙 占쏙옙 占쌩곤옙
        model.addAttribute("currentPage", pagingInfo.getCurrentPage()); // 占쏙옙체 占쏙옙占쏙옙占쏙옙 占쏙옙 占쌩곤옙
        
        
        System.out.println("占싯삼옙 : " + totalPostCnt);
        
        if (totalPostCnt == 0) {
        	model.addAttribute("noResult", true);
        }
        
        
        // 占쏙옙占쏙옙占싱놂옙 占싯삼옙占쏘가 占쏙옙占쏙옙 占쏙옙 처占쏙옙
        if (search == null || search.trim().isEmpty()) {
            
            // 카占쌓곤옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌔댐옙 카占쌓곤옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏜렉쇽옙
            if (category != null) {
                return "redirect:/product/jewelry?category=" + category;
            }

            // 카占쌓곤옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占� 占썩본 占쏙옙체 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏜렉쇽옙
            return "redirect:/product/jewelry/all";
        }
        
        if (search != null) {
            search = search.trim(); // 占쌌듸옙 占쏙옙占쏙옙 占쏙옙占쏙옙
            search = search.replaceAll("[<>\"'&]", ""); // 특占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 (占십요에 占쏙옙占쏙옙 占쏙옙占쏙옙)
        }
        
        // 占쏙옙 카占쌓곤옙占쏙옙占쏙옙 占쏙옙품 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);
        // 카占쌓곤옙占쏙옙占쏙옙 占쏙옙품 占쏙옙占쏙옙 占쏙옙占쏙옙
        model.addAttribute("necklaceCount", necklaceCount);
        model.addAttribute("earringCount", earringCount);
        model.addAttribute("piercingCount", piercingCount);
        model.addAttribute("bangleCount", bangleCount);
        model.addAttribute("ankletCount", ankletCount);
        model.addAttribute("ringCount", ringCount);
        model.addAttribute("couplingCount", couplingCount);
        model.addAttribute("pendantCount", pendantCount);
        model.addAttribute("otherCount", otherCount);
    	

    	return "/user/pages/product/productList";
    }
}