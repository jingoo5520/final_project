package com.finalProject.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

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
public class NoticeVO {
	private int noticeNo;
	private String noticeType;
	private String noticeTitle;
	private String noticeContent;
	private LocalDateTime regDate;
	private String adminId;
	private Timestamp noticeEndDate;
}
