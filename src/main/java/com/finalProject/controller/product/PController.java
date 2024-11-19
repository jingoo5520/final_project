package com.finalProject.controller.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.product.PagingInfo;
import com.finalProject.model.product.PagingInfoDTO;
import com.finalProject.model.product.ProductDTO;
import com.finalProject.model.review.ProductDetailReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;
import com.finalProject.service.member.MemberService;
import com.finalProject.service.product.UserProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/product")
public class PController {

    @Autowired
    private UserProductService service;


	@Autowired
	private MemberService memberService;

	// 1. 전체 상품을 표시함 (카테고리 선택 없이 전체 상품 표시)
	@GetMapping("/jewelry/all")
	public String showProductList(HttpServletRequest request,
			@RequestParam(value = "category", required = false) Integer category,
			@RequestParam(value = "page", defaultValue = "1") int page, // 페이지 기본 값 설정
			@RequestParam(value = "pageSize", defaultValue = "6") int pageSize, // 한 페이지에서 보여줄 상품 개수
			@RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder, Model model) throws Exception  {

		List<ProductDTO> products = service.getProductsByPage(page, pageSize); // 전체 상품 조회

		// 전체 상품 개수 계산
		int totalProducts = service.getProductCount();
		int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

		// 한 번에 보여줄 페이지 블록 설정 (예: 10페이지씩)
		int pageBlockSize = 10;
		int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
		int startPage = (currentBlock - 1) * pageBlockSize + 1;
		int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);
		int totalProductCount = service.getProductCount();

		// 찜
		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember"); // 로그인정보 받기
		if (loginDTO != null) { // 로그인 상태 확인
			int wishList[] = memberService.getWishList(loginDTO.getMember_id()); // member_id로 찜목록 조회
			model.addAttribute("wishList", wishList);
//			System.out.println("찜목록 조회");
		}

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
		model.addAttribute("sortOrder", sortOrder); // 정렬 기준 추가
		model.addAttribute("category", category); // 카테고리 추가
		model.addAttribute("totalProducts", totalProducts);

		// 각 카테고리별 상품 개수 조회
		int necklaceCount = service.getProductCountByCategory(196);
		int earringCount = service.getProductCountByCategory(195);
		int piercingCount = service.getProductCountByCategory(203);
		int bangleCount = service.getProductCountByCategory(197);
		int ankletCount = service.getProductCountByCategory(201);
		int ringCount = service.getProductCountByCategory(198);
		int couplingCount = service.getProductCountByCategory(200);
		int pendantCount = service.getProductCountByCategory(202);
		int otherCount = service.getProductCountByCategory(204);
		// 각 카테고리별 상품 개수 추가
		model.addAttribute("necklaceCount", necklaceCount);
		model.addAttribute("earringCount", earringCount);
		model.addAttribute("piercingCount", piercingCount);
		model.addAttribute("bangleCount", bangleCount);
		model.addAttribute("ankletCount", ankletCount);
		model.addAttribute("ringCount", ringCount);
		model.addAttribute("couplingCount", couplingCount);
		model.addAttribute("pendantCount", pendantCount);
		model.addAttribute("otherCount", otherCount);
		
		model.addAttribute("currentCategory", category == null ? "all" : category.toString());

		System.out.println(category == null ? "all" : category.toString());

		return "/user/pages/product/productList"; // jsp 페이지로 반환
	}

	// 2. 카테고리별 상품을 표시함
	@GetMapping("/jewelry")
	public String showProductList(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "pageSize", defaultValue = "6") int pageSize,
			@RequestParam(value = "category", required = false) Integer category,
			@RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder, Model model,
			HttpServletRequest request) throws Exception {

		sortOrder = sortOrder.trim();

		List<ProductDTO> products = service.getProductsByCategoryAndPage(category, page, pageSize, sortOrder);

		int totalProducts = service.getProductCountByCategory(category);
		int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
		int totalProductCount = service.getProductCount();


		// 페이지 블록 설정
		int pageBlockSize = 10;
		int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
		int startPage = (currentBlock - 1) * pageBlockSize + 1;
		int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);

		// 각 카테고리별 상품 개수 조회
		int necklaceCount = service.getProductCountByCategory(196);
		int earringCount = service.getProductCountByCategory(195);
		int piercingCount = service.getProductCountByCategory(203);
		int bangleCount = service.getProductCountByCategory(197);
		int ankletCount = service.getProductCountByCategory(201);
		int ringCount = service.getProductCountByCategory(198);
		int couplingCount = service.getProductCountByCategory(200);
		int pendantCount = service.getProductCountByCategory(202);
		int otherCount = service.getProductCountByCategory(204);

		// 찜
		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember"); // 로그인정보 받기
		if (loginDTO != null) { // 로그인 상태 확인
			int wishList[] = memberService.getWishList(loginDTO.getMember_id()); // member_id로 찜목록 조회
			model.addAttribute("wishList", wishList);
//			System.out.println("찜목록 조회");
		}

		// 각 카테고리별 상품 개수 추가
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
		model.addAttribute("currentCategory", category == null ? "all" : category.toString());
//		System.out.println("카테고리별 상품 수 : " + totalProducts);
		return "/user/pages/product/productList"; // JSP 페이지로 반환
	}

	// 3. 상품의 세부 정보를 표시함
	@GetMapping("/jewelry/detail")
	public String showProductDetail(@RequestParam("productNo") int productNo, 
			Model model, HttpServletRequest request
			) throws Exception {

        // 상품 상세 정보 조회
        List<ProductDTO> products = service.getProductInfo(productNo);
        // 세부 상품 정보 조회
        ProductDTO product = service.getProductDetailById(productNo);
        
        // 상품 리뷰 조회
//        List<ReviewDetailDTO> seeReview = service.getReviewDetail(productNo);
        // 상품 리뷰 이미지 조회
//        List <String> reviewImgs = service.getReviewImgs(productNo);
        
        // Model에 데이터 추가
//        model.addAttribute("reviews", seeReview);
//        model.addAttribute("reviewImgs", reviewImgs);
		// 찜
		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember"); // 로그인정보 받기
		if (loginDTO != null) { // 로그인 상태 확인
			int wishList[] = memberService.getWishList(loginDTO.getMember_id()); // member_id로 찜목록 조회
			model.addAttribute("wishList", wishList);
//			System.out.println("찜목록 조회");
		}
        
        model.addAttribute("products", products);
        model.addAttribute("product_content", product.getProduct_content());
        model.addAttribute("calculatedPrice", product.getCalculatedPrice());  // 계산된 가격 추가
        return "/user/pages/product/productDetail";
    }
	
	@GetMapping("/review/load")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> loadReviews(@RequestParam int productNo,  
			@RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "1") int size) throws Exception {
	    
	    // 1. 총 리뷰 개수 조회
	    int totalPostCnt = service.countReview(productNo);
//        System.out.println("Total Review Count: " + totalPostCnt);
        
        int offset = (page - 1) * size;
        
        // 상품 리뷰 조회
//        List<ReviewDetailDTO> seeReview = service.getReviewDetail(productNo, offset, size);
        
        // 상품 리뷰 이미지 조회
//        List <String> reviewImgs = service.getReviewImgs(productNo);
        
        // 리뷰 이미지까지 한 번에 조회
        List<ProductDetailReviewDTO> seeReview = service.getReviewDetail(productNo, offset, size);
        
        Map<String, Object> response = new HashMap<String, Object>();
		PagingInfoDTO pagingInfoDTO = new PagingInfoDTO(page, 3);
		PagingInfo pagingInfo = new PagingInfo(pagingInfoDTO, totalPostCnt);

//		System.out.println(pagingInfo);
		response.put("pagingInfo", pagingInfo);
        response.put("seeReview", seeReview);
//        response.put("reviewImgs", reviewImgs);
        response.put("totalPostCnt", totalPostCnt);
        
        // JSON 형태로 출력하기 위해 ObjectMapper 사용
//        ObjectMapper mapper = new ObjectMapper();
//        String jsonString = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(response);
        
//        System.out.println(totalPostCnt);
//        System.out.println(jsonString);
        
	    return ResponseEntity.ok(response);
	    
    }



	// 4. 검색기능
	@GetMapping("/jewelry/result")
	public String search(@RequestParam(required = false) String search, // 검색어
			@RequestParam(required = false) Integer category, // 카테고리 (선택)
			@RequestParam(defaultValue = "1") int page, // 현재 페이지 번호
			@RequestParam(value = "sortOrder", defaultValue = "new") String sortOrder, Model model) throws Exception {

//		System.out.println("검색검색 : search=" + search + ", category=" + category + ", page=" + page + ", sortOrder=" + sortOrder);

		// 1. 총 게시물 수 조회
		int totalPostCnt = service.countSearchResults(search, category);

		// 2. 페이징 정보 생성
		PagingInfoDTO pagingInfoDTO = new PagingInfoDTO(page, 9); // 한 페이지당 9개씩 조회
		PagingInfo pagingInfo = new PagingInfo(pagingInfoDTO, totalPostCnt);

		// 3. 검색 결과 조회
		List<ProductDTO> searchResults = service.searchProducts(search, category, pagingInfo, sortOrder);
//		System.out.println("데이터");
//		System.out.println(searchResults);

		// 4. 모델에 검색 결과 및 페이징 정보 담기
		model.addAttribute("products", searchResults);
		model.addAttribute("pagingInfo", pagingInfo);
		model.addAttribute("search", search);
		model.addAttribute("category", category);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute("searchProductCount", totalPostCnt);
		model.addAttribute("startPage", pagingInfo.getStartPage()); // 시작 페이지 추가
		model.addAttribute("endPage", pagingInfo.getEndPage()); // 끝 페이지 추가
		model.addAttribute("totalPages", pagingInfo.getTotalPages()); // 전체 페이지 수 추가
		model.addAttribute("currentPage", pagingInfo.getCurrentPage()); // 현재 페이지 추가
		model.addAttribute("hasPrevBlock", pagingInfo.hasPrevBlock()); // 이전 페이지 추가
		model.addAttribute("hasNextBlock", pagingInfo.hasNextBlock()); // 다음 페이지 추가
		model.addAttribute("currentCategory", category == null ? "all" : category.toString());

//		System.out.println("검색 : " + totalPostCnt);

		if (totalPostCnt == 0) {
			model.addAttribute("noResult", true);
		}

		// 검색어가 없을 때 처리
		if (search == null || search.trim().isEmpty()) {

			// 카테고리가 선택된 상태에서 검색어가 없으면 해당 카테고리로 리디렉션
			if (category != null) {
				return "redirect:/product/jewelry?category=" + category;
			}

			// 카테고리가 없는 경우 전체 상품 페이지로 리디렉션
			return "redirect:/product/jewelry/all";
		}

		if (search != null) {
			search = search.trim(); // 검색어 공백 제거
			search = search.replaceAll("[<>\"'&]", ""); // 특수 문자 필터링 (보안상의 이유로 필수)
		}

		// 각 카테고리별 상품 개수 조회
		int necklaceCount = service.getProductCountByCategory(196);
		int earringCount = service.getProductCountByCategory(195);
		int piercingCount = service.getProductCountByCategory(203);
		int bangleCount = service.getProductCountByCategory(197);
		int ankletCount = service.getProductCountByCategory(201);
		int ringCount = service.getProductCountByCategory(198);
		int couplingCount = service.getProductCountByCategory(200);
		int pendantCount = service.getProductCountByCategory(202);
		int otherCount = service.getProductCountByCategory(204);
		// 각 카테고리별 상품 개수 추가
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
