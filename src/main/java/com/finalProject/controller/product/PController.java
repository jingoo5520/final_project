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
import com.finalProject.service.product.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/product")
public class PController {

    @Autowired
    private UserProductService service;

    // 1. ��ü ��ǰ�� �����ִ� �޼��� (ī�װ� ���� ��ü ��ǰ ǥ��)
    @GetMapping("/jewelry/all")
    public String showProductList(
            @RequestParam(value = "category", required = false) Integer category,
            @RequestParam(value = "page", defaultValue = "1") int page, // ������ ����Ʈ �� ����
            @RequestParam(value = "pageSize", defaultValue = "6") int pageSize, // �� ���������� ������ ��ǰ ����
            @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
            Model model) throws Exception {

        List<ProductDTO> products = service.getProductsByPage(page, pageSize);  // ��ü ��ǰ ��ȸ
        
        
        // ��ü ��ǰ ���� ���
        int totalProducts = service.getProductCount();  
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // �� ���� ������ ������ ��� ���� (��: 10��������)
        int pageBlockSize = 10;
        int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
        int startPage = (currentBlock - 1) * pageBlockSize + 1;
        int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);
        int totalProductCount = service.getProductCount();

        // Model�� ������ �߰�
        model.addAttribute("totalProductCount", totalProductCount);
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasPrevBlock", currentBlock > 1);
        model.addAttribute("hasNextBlock", endPage < totalPages);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("sortOrder", sortOrder);  // ���� ���� �߰�
        model.addAttribute("category", category);  // ī�װ� �߰�
        model.addAttribute("totalProducts", totalProducts);
        System.out.println("all : " + totalProducts);
        
        // �� ī�װ����� ��ǰ ���� ����
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);
        // ī�װ����� ��ǰ ���� ����
        model.addAttribute("necklaceCount", necklaceCount);
        model.addAttribute("earringCount", earringCount);
        model.addAttribute("piercingCount", piercingCount);
        model.addAttribute("bangleCount", bangleCount);
        model.addAttribute("ankletCount", ankletCount);
        model.addAttribute("ringCount", ringCount);
        model.addAttribute("couplingCount", couplingCount);
        model.addAttribute("pendantCount", pendantCount);
        model.addAttribute("otherCount", otherCount);

        return "/user/pages/product/productList"; // jsp ���� ��ȯ
    }

    // 2. ī�װ����� ��ǰ�� �����ִ� �޼���
    @GetMapping("/jewelry")
    public String showProductList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "6") int pageSize,
            @RequestParam(value = "category", required = false) Integer category,
            @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
            Model model) throws Exception {

        System.out.println("ī�װ��� �� : " + category);
        sortOrder = sortOrder.trim();

        List<ProductDTO> products = service.getProductsByCategoryAndPage(category, page, pageSize, sortOrder);

        int totalProducts = service.getProductCountByCategory(category);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        int totalProductCount = service.getProductCount();

        System.out.println("��ü ��ǰ ��: " + totalProducts);
        System.out.println("Received sortOrder: '" + sortOrder + "'");

        // ���������̼� ����
        int pageBlockSize = 10;
        int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
        int startPage = (currentBlock - 1) * pageBlockSize + 1;
        int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);

        // �� ī�װ��� ��ǰ ���� ��������
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);
        // ī�װ����� ��ǰ ���� ����
        model.addAttribute("necklaceCount", necklaceCount);
        model.addAttribute("earringCount", earringCount);
        model.addAttribute("piercingCount", piercingCount);
        model.addAttribute("bangleCount", bangleCount);
        model.addAttribute("ankletCount", ankletCount);
        model.addAttribute("ringCount", ringCount);
        model.addAttribute("couplingCount", couplingCount);
        model.addAttribute("pendantCount", pendantCount);
        model.addAttribute("otherCount", otherCount);

        // Model�� ������ �߰�
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
        


        System.out.println("ī�װ��� : " + totalProducts);
        return "/user/pages/product/productList";  // JSP ���� ��ȯ
    }

    // 3. ��ǰ �� ������ �����ִ� �޼���
    @GetMapping("/jewelry/detail")
    public String showProductDetail(
            @RequestParam("productNo") int productId,
            Model model) throws Exception {

        // ��ǰ ���� ��������
        List<ProductDTO> products = service.getProductInfo(productId);

        // �� ���� ��������
        ProductDTO product = service.getProductDetailById(productId);

        // Model�� ������ �߰�
        model.addAttribute("products", products);
        model.addAttribute("product_content", product.getProduct_content());
        model.addAttribute("calculatedPrice", product.getCalculatedPrice());  // ���� ���� �߰�
        return "/user/pages/product/productDetail";
    }
    
    // 4. �˻����
    @GetMapping("/jewelry/result")
    public String search (
    		@RequestParam(required = false) String search, // �˻���
	        @RequestParam(required = false) Integer category, // ī�װ��� (����)
	        @RequestParam(defaultValue = "1") int page, // ���� ������ ��ȣ
	        @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
    		Model model) throws Exception {
    	
    	System.out.println("�˻��˻� : search=" + search + ", category=" + category + 
                ", page=" + page + ", sortOrder=" + sortOrder);
    	

    	
        // 1. �� �Խù� �� ��ȸ
        int totalPostCnt = service.countSearchResults(search, category);
        
        // 2. ����¡ ���� ����
        PagingInfoDTO pagingInfoDTO = new PagingInfoDTO(page, 9); // �� �������� 9���� ��ȸ
        PagingInfo pagingInfo = new PagingInfo(pagingInfoDTO, totalPostCnt);

        // 3. �˻� ��� ��ȸ
        List<ProductDTO> searchResults = service.searchProducts(search, category, pagingInfo, sortOrder);
        System.out.println("������");
        System.out.println(searchResults);
        
        
        // 4. �𵨿� �˻� ��� �� ����¡ ���� ���
        model.addAttribute("products", searchResults);
        model.addAttribute("pagingInfo", pagingInfo);
        model.addAttribute("search", search);
        model.addAttribute("category", category);
        model.addAttribute("sortOrder", sortOrder);
        model.addAttribute("searchProductCount", totalPostCnt);
        model.addAttribute("startPage", pagingInfo.getStartPage()); // ���� ������ �߰�
        model.addAttribute("endPage", pagingInfo.getEndPage()); // �� ������ �߰�
        model.addAttribute("totalPages", pagingInfo.getTotalPages()); // ��ü ������ �� �߰�
        model.addAttribute("currentPage", pagingInfo.getCurrentPage()); // ��ü ������ �� �߰�
        
        
        System.out.println("�˻� : " + totalPostCnt);
        
        if (totalPostCnt == 0) {
        	model.addAttribute("noResult", true);
        }
        
        
        // �����̳� �˻�� ���� �� ó��
        if (search == null || search.trim().isEmpty()) {
            
            // ī�װ��� ���� ������ �ش� ī�װ��� �������� ���𷺼�
            if (category != null) {
                return "redirect:/product/jewelry?category=" + category;
            }

            // ī�װ����� ���� ��� �⺻ ��ü �������� ���𷺼�
            return "redirect:/product/jewelry/all";
        }
        
        if (search != null) {
            search = search.trim(); // �յ� ���� ����
            search = search.replaceAll("[<>\"'&]", ""); // Ư�� ���� ���� ���� (�ʿ信 ���� ����)
        }
        
        // �� ī�װ����� ��ǰ ���� ��������
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);
        // ī�װ����� ��ǰ ���� ����
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