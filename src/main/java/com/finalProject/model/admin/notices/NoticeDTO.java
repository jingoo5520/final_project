package com.finalProject.model.admin.notices;

import java.time.LocalDateTime;
import java.util.List;

import com.finalProject.model.admin.notices.NoticeTypeStatus.NoticeType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class NoticeDTO {
	private int notice_no;
	private String notice_title;
	private String admin_id;
	private String notice_content;
	private NoticeTypeStatus.NoticeType notice_type;
	private LocalDateTime reg_date;
	private LocalDateTime event_start_date;
	private LocalDateTime event_end_date;
	
    private String banner_image;
    private String thumbnail_image;
    private String url;
	
}
