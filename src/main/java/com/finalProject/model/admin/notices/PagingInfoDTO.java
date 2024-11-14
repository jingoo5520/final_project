package com.finalProject.model.admin.notices;

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
public class PagingInfoDTO {
   private int pageNo;
   private int pagingSize; // 한 페이지에 보여줄 글의 갯수
   private int PageCntPerBlock; // 한 블럭에서 보여질 페이지 개수

// 시작 행 인덱스 계산
public int getStartRowIndex() {
    return (pageNo - 1) * pagingSize;
}
}
