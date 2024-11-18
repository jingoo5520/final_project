package com.finalProject.model.admin.order;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AdminRefundVO {
	private int refund_no;
	private int cancel_no;
	private int payment_num;
	private String refund_type;
	private Date refund_receive_date;
	private int refund_amount;
}
