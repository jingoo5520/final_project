package com.finalProject.model;

import java.time.LocalDateTime;
import java.util.List;

import com.finalProject.model.NoticeTypeStatus.NoticeType;

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
	
}
