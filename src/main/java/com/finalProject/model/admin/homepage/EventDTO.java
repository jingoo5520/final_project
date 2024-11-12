package com.finalProject.model.admin.homepage;

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
public class EventDTO {
	private int notice_no;
	private String notice_title;
	private String banner_image; // uri
	private String thumbnail_image; // uri
}
