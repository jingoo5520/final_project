package com.finalProject.model.admin.notices;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

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
	
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime reg_date;
    private String formatted_reg_date;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime event_start_date;
    private String formatted_event_start_date;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime event_end_date;
    private String formatted_event_end_date;
    
	
    private String banner_image;
    private String thumbnail_image;
    private String url;
	
}
