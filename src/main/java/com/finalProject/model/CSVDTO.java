package com.finalProject.model;

import org.springframework.web.multipart.MultipartFile;

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
public class CSVDTO {
	private String name;
	private int price;
	private String content;
	private String fileName;
	private String cnt;
	private String dcType;
	private String dcAmount;
	private String dcRate;
	private String sellCount;
	private String category;
	private String cost;
	private MultipartFile file;
}
