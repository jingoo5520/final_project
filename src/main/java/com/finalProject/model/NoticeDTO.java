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
	private NoticeType noticeType;
	private String noticeTitle;
	private LocalDateTime regDate;
	private String noticeContent;
	private String adminId;
	
	private List<NoticeImagesDTO> fileList;
	
}
