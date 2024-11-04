package com.finalProject.model.review;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class ReviewPagingInfoDTO {
    private int pageNo;          // 현재 페이지 번호
    private int pageSize;        // 페이지당 게시물 수
    private int totalPostCnt;    // 전체 게시물 수

    public ReviewPagingInfoDTO(int pageNo, int pageSize) {
        this.pageNo = pageNo > 0 ? pageNo : 1;  // 페이지 번호가 1보다 작으면 기본값 1 설정
        this.pageSize = pageSize > 0 ? pageSize : 10;  // 페이지 크기가 0보다 작으면 기본값 10 설정
    }

    // 전체 게시물 수를 설정하고 전체 페이지 수를 계산
    public void setTotalPostCnt(int totalPostCnt) {
        this.totalPostCnt = totalPostCnt;
    }
}
