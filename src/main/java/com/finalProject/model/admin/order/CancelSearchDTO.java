package com.finalProject.model.admin.order;

import java.util.List;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class CancelSearchDTO {
	private List<String> cancel_type;
	private List<String> cancel_status;
	private String cancel_apply_date_start;
	private String cancel_apply_date_end;
	private int pageNo;
	private int pagingSize;
}
