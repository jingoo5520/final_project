package com.finalProject.controller.admin.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.order.AdminCancleVO;
import com.finalProject.model.admin.order.CancelSearchDTO;
import com.finalProject.model.admin.product.adminPagingInfoDTO;
import com.finalProject.service.admin.orders.OrdersService;

@Controller
@RequestMapping("/admin/order/")
public class MemberOrderController {

	@Autowired
	private OrdersService os;

	@RequestMapping("cancel")
	public String CancelView(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "pagingSize", defaultValue = "10") int PagingSize) {
		adminPagingInfoDTO dto = adminPagingInfoDTO.builder().pageNo(pageNo).pagingSize(PagingSize).build();
		Map<String, Object> map = new HashMap<String, Object>();
		List<AdminCancleVO> list = new ArrayList<>();
		try {
			map = os.getAllCancle(dto);
			if (map.size() <= 1) {
				return "admin/pages/ordermanage/cancel?status=fail";
			}

			model.addAttribute("CancleList", map.get("CancleList"));
			System.out.println(map.get("CancleList"));
			model.addAttribute("PagingInfo", map.get("PagingInfo"));
			model.addAttribute("TopCancleList", map.get("TopCancleList"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/pages/ordermanage/cancel";
	}

	@RequestMapping("refund")
	public String RefundView(Model model) {

		return "admin/pages/ordermanage/refund";
	}

	@RequestMapping("total")
	public String ViewTotal(Model model) {

		return "admin/pages/total/test";
	}

	@RequestMapping("changeStatus")
	@ResponseBody
	public void ChangeStatus(@RequestParam("cancel_no") String cancel_no,
			@RequestParam("orderproduct_no") String orderproduct_no) {

		System.out.println("?!@$!@$" + cancel_no);
		System.out.println("!%!@%!%!" + orderproduct_no);
	}

	@RequestMapping("searchFilter")
	@ResponseBody
	public ResponseEntity<Object> SearchFilter(@RequestBody CancelSearchDTO search) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		adminPagingInfoDTO dto = adminPagingInfoDTO.builder().pageNo(search.getPageNo())
				.pagingSize(search.getPagingSize()).build();
		System.out.println(search.toString());
		try {
			returnMap = os.getSearchFilter(search, dto);
			return ResponseEntity.ok(returnMap); // 성공적으로 데이터를 반환
		} catch (Exception e) {
			returnMap.put("fail", "fail");
			System.err.println("Error occurred: " + e.getMessage());
			// 로깅 처리
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(returnMap); // 에러 발생 시 500 상태 코드 반환
		}
	}
}
