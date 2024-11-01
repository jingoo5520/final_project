package com.finalProject.model.admin.order;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminCancleVO {
	private int cancel_no;
	private int orderproduct_no;
	private Date cancel_apply_date;
	private Date cancel_complete_date;
	private Date cancel_retract_date;
	private String cancel_type;
	private String cancel_status;
	private String cancel_reason;
}
