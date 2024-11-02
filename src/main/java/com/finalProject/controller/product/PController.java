package com.finalProject.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.finalProject.model.admin.product.ProductDTO;
import com.finalProject.service.product.UserProductService;

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
            @RequestParam(value = "pageSize", defaultValue = "18") int pageSize, // �� ���������� ������ ��ǰ ����
            @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
            Model model) throws Exception {

        List<ProductDTO> products = service.getProductsByPage(page, pageSize);  // ��ü ��ǰ ��ȸ
        
        
        int totalProducts = service.getProductCount();  // ��ü ��ǰ ���� ���
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

        // �� ī�װ��� ��ǰ ���� ����
        int necklaceCount = service.getProductCountByCategory(196);
        int earringCount = service.getProductCountByCategory(195);
        int piercingCount = service.getProductCountByCategory(203);
        int bangleCount = service.getProductCountByCategory(197);
        int ankletCount = service.getProductCountByCategory(201);
        int ringCount = service.getProductCountByCategory(198);
        int couplingCount = service.getProductCountByCategory(200);
        int pendantCount = service.getProductCountByCategory(202);
        int otherCount = service.getProductCountByCategory(204);

        // ī�װ��� ��ǰ ���� ����
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
            @RequestParam(value = "pageSize", defaultValue = "18") int pageSize,
            @RequestParam(value = "category", required = false) Integer category,
            @RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder,
            Model model) throws Exception {

        log.info("ī�װ� �� : " + category);
        sortOrder = sortOrder.trim();

        List<ProductDTO> products = service.getProductsByCategoryAndPage(category, page, pageSize, sortOrder);
        
     // �� ��ǰ�� ���� ������ ����
        for (ProductDTO product : products) {
            product.setCalculatedPrice(product.getCalculatedPrice());
        }

        int totalProducts = service.getProductCountByCategory(category);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        int totalProductCount = service.getProductCount();

        log.info("��ü ��ǰ ��: " + totalProducts);
        log.info("Received sortOrder: '" + sortOrder + "'");

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

        // ī�װ��� ��ǰ ���� ����
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
}
