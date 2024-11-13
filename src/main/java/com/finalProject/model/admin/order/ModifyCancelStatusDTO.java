package com.finalProject.model.admin.order;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ModifyCancelStatusDTO {
	private int amount;
	private List<String> cancelList;
	private int paymentNo;
	private String cancelType;
	private int assigned_point;
}
