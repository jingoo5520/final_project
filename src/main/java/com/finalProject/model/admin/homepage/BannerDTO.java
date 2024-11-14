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
public class BannerDTO {
	private int banner_no;
	private String notice_title;
	private String banner_type;
	private String banner_image;
	private String thumbnail_image;
	private String url;
}
