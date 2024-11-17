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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.order.AdminCancleVO;
import com.finalProject.model.admin.order.AdminGetCancel;
import com.finalProject.model.admin.order.AdminPaymentVO;
import com.finalProject.model.admin.order.AdminSearchRefundDTO;
import com.finalProject.model.admin.order.CancelSearchDTO;
import com.finalProject.model.admin.order.ModifyCancelStatusDTO;
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
			System.out.println(map.get("PagingInfo"));
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
	public String RefundView(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "pagingSize", defaultValue = "10") int PagingSize) {
		adminPagingInfoDTO dto = adminPagingInfoDTO.builder().pageNo(pageNo).pagingSize(PagingSize).build();
		Map<String, Object> map = new HashMap<String, Object>();
		List<AdminCancleVO> list = new ArrayList<>();
		try {
			map = os.getAllrefund(dto);
			if (map.size() <= 1) {
				return "admin/pages/ordermanage/cancel?status=fail";
			}

			model.addAttribute("refundList", map.get("refundList"));
			System.out.println(map.get("PagingInfo"));
			System.out.println(map.get("refundList"));
			model.addAttribute("PagingInfo", map.get("PagingInfo"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/pages/ordermanage/refund";
	}

	@RequestMapping("total")
	public String ViewTotal(Model model) {

		return "admin/pages/total/test";
	}

	@RequestMapping(value = "cancelOrder", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<AdminPaymentVO> ChangeStatus(@RequestBody AdminGetCancel cancelDto) {

		try {
			if (cancelDto == null || cancelDto.getList().size() <= 0) {
				throw new IllegalArgumentException("취소번호와 주문번호는 필수 입니다.");
			}

			// cancelNo를 통해 refund 객체 조회
			AdminPaymentVO refund = os.getPaymentModuleKeyByOrderId(cancelDto);

			if (refund.getPayment_method() == null || refund.getPayment_method() == "" || refund.getPaid_amount() <= 0
					|| refund.getPayment_module_key() == null || refund.getPayment_module_key() == "") {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}

			// 필요한 값 출력 (디버깅 용도)
			System.out.println(refund.getCancel_reason());
			System.out.println(refund.getPaid_amount());
			System.out.println(refund.getPayment_module_key());
			System.out.println(refund.getPayment_method());
			System.out.println(refund.getCancel_type());

			return new ResponseEntity<>(refund, HttpStatus.OK); // 성공 시 200 반환
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			// 예상치 못한 예외 처리
			e.printStackTrace(); // 로그를 남기기 위해 스택 트레이스를 출력
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
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
			return ResponseEntity.ok(returnMap);
		} catch (Exception e) {
			returnMap.put("fail", "fail");
			System.err.println("Error: " + e.getMessage());

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(returnMap);
		}
	}

	@RequestMapping("modifyStatus")
	@ResponseBody
	public ResponseEntity<Object> ModifyCancelStatus(@RequestBody ModifyCancelStatusDTO modifyCancelStatusDTO) {
		boolean result = false;

		System.out.println("총 가격 " + modifyCancelStatusDTO.getAmount());
		System.out.println("취소 번호" + modifyCancelStatusDTO.getCancelList().toString());
		System.out.println("취소 타입 " + modifyCancelStatusDTO.getCancelType());
		System.out.println("결제 번호 " + modifyCancelStatusDTO.getPaymentNo());
		modifyCancelStatusDTO.getAssigned_point();
		try {
			result = os.modifyCancelStatus(modifyCancelStatusDTO);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new Response("fail"));
		}
		if (result) {
			return ResponseEntity.status(HttpStatus.OK).body(new Response("결제 정보 변경 success"));
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new Response("fail"));
		}
	}

	@RequestMapping("showListByOrderId")
	@ResponseBody
	public ResponseEntity<Object> ShowListByOrderId(@RequestParam("orderId") String orderId) {
		List<AdminCancleVO> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(orderId);
		try {
			if (orderId != null && orderId != "") {
				list = os.getListByOrderId(orderId);

				map.put("orderIdList", list);
			}
		} catch (Exception e) {
			System.out.println("Exception occurred: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("fail");
		}
		return ResponseEntity.status(HttpStatus.ACCEPTED).body(map);

	}

	@RequestMapping("restractCancelNo")
	@ResponseBody
	public ResponseEntity<Response> RestractCancelNo(@RequestParam("cancelNo") String cancelNo) {
		try {

			if (cancelNo == null || cancelNo.isEmpty()) {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new Response("fail"));
			}

			int result = os.RestractByCancelNo(cancelNo);
			System.out.println(result);

			if (result >= 1) {
				return ResponseEntity.status(HttpStatus.OK).body(new Response("success"));
			} else {

				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new Response("fail"));
			}

		} catch (Exception e) {

			System.err.println("Error during restractCancelNo: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new Response("fail"));
		}
	}

	public class Response {
		private String errorCode;

		public Response(String errorCode) {
			this.errorCode = errorCode;
		}

		public String getResponseCode() {
			return errorCode;
		}

		public void setResponseCode(String errorCode) {
			this.errorCode = errorCode;
		}
	}

	@RequestMapping("searchRefundFilter")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> SearchRefundFilter(@RequestBody AdminSearchRefundDTO searchDto) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		adminPagingInfoDTO pagingDto = adminPagingInfoDTO.builder().pageNo(searchDto.getPageNo())
				.pagingSize(searchDto.getPagingSize()).build();
		System.out.println(searchDto.toString());
		try {
			returnMap = os.getSearchRefundFilter(searchDto, pagingDto);
			return ResponseEntity.ok(returnMap);
		} catch (Exception e) {
			returnMap.put("fail", "fail");
			System.err.println("Error: " + e.getMessage());

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(returnMap);
		}
	}
}
