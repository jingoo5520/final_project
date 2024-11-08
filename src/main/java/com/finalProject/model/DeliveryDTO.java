package com.finalProject.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Getter
@Setter
public class DeliveryDTO {
	private int delivery_no;
	private String delivery_name;
	private String delivery_address;
	private String member_id;
	private String is_main;
}
