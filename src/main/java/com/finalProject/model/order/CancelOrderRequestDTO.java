package com.finalProject.model.order;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class CancelOrderRequestDTO {
	private String orderId;
	private List<ProductCancelRequestDTO> products; // orderproductNo, request("환불신청" or "환불취소")가 담겨있음
	private String cancelReason;
	private String cancelType;
	private String accountOwner;
	private String accountBank;
	private String accountNumber;
}
