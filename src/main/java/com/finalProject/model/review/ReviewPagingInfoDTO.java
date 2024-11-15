package com.finalProject.model.review;

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
public class ReviewPagingInfoDTO {
    private int pageNo;          // 현재 페이지 번호
    private int pageSize;        // 한 페이지당 게시물 수
    private int totalPostCnt;    // 전체 게시물 수

    public ReviewPagingInfoDTO(int pageNo, int pageSize) {
        this.pageNo = pageNo > 0 ? pageNo : 1;  // 페이지 번호가 1 이상이어야 하므로 기본값은 1로 설정
        this.pageSize = pageSize > 0 ? pageSize : 10;  // 페이지 크기가 0 이상이어야 하므로 기본값은 10으로 설정
    }

    // 전체 게시물 수를 설정하고 전체 페이지 수 계산하기 위해 사용
    public void setTotalPostCnt(int totalPostCnt) {
        this.totalPostCnt = totalPostCnt;
    }
}
