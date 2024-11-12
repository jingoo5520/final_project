package com.finalProject.model.admin.order;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AdminSuccessCancelDTO {
	private int amount;
	private int cancelNo;
	private int paymentNo;
	private String cancelType;
}
