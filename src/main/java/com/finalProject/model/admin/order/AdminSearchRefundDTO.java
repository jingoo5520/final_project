package com.finalProject.model.admin.order;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class AdminSearchRefundDTO {
	private String refund_start_date;
	private String refund_end_date;
	private List<String> refund_type;
	private int pageNo;
	private int pagingSize;
}
