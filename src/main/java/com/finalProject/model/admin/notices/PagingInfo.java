package com.finalProject.model.admin.notices;

import java.util.List;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PagingInfo {
   
   // -- 기본 페이징 출력에 필요한 변수들
   private int pageNo; // 현재 페이지 번호
   private int viewPostCntPerPage; // 한 페이지 당 보여줄 글의 갯수
   
   private int totalPostCnt; // 전체 글(데이터)의 갯수
   private int totalPageCnt; // 전체 페이지 수
   private int startRowIndex; // 현재 페이지에서 보여주기 시작할 글의 index 번호
   // -----------------------------------------------------------
   
   // -- 페이징 블럭을 만들 때 필요한 변수들
   private int pageCntPerBlock = 10; // 하나의 페이징 블럭에서 보여줄 페이지 수
   private int pageBlockNoCurPage; // 현재 페이지가 속한 페이징 블럭 번호
   private int startPageNoCurBlock; // 현재 페이징 블럭의 시작 페이지 번호
   private int endPageNoCurBlock; // 현재 페이징 블럭의 마지막 페이지 번호
   // -----------------------------------------------------------
   
   public PagingInfo(PagingInfoDTO dto) {
      this.pageNo = dto.getPageNo();
      this.viewPostCntPerPage = dto.getPagingSize();
      this.pageCntPerBlock = dto.getPageCntPerBlock();
   }
   
   public void setTotalPostCnt(int totalPostCnt2, SearchCriteriaDTO criteria) {
	    this.totalPostCnt = totalPostCnt2;
	    // (검색 로직은 나중에 서비스 계층에서 처리)
	    if (this.totalPostCnt > 0 && this.viewPostCntPerPage > 0) {
	        this.totalPageCnt = (int) Math.ceil((double) this.totalPostCnt / this.viewPostCntPerPage);
	    } else {
	        this.totalPageCnt = 0; // 게시물이 없거나 페이지당 게시물 수가 0이면 페이지 수는 0
	    }
	}
   
   public void setTotalPageCnt() {
      // => 전체 페이지 수 : 전체 글의 수 / 1페이지당 보여줄 글의 갯수
      //              -> 나누어 떨어지면 몫이 페이지 수가 됨
      //              -> 나누어 떨어지지 않으면 몫 + 1이 페이지 수가 됨
      if (this.totalPostCnt % this.viewPostCntPerPage == 0) {
         this.totalPageCnt = this.totalPostCnt / this.viewPostCntPerPage;
      } else {
         this.totalPageCnt = this.totalPostCnt / this.viewPostCntPerPage + 1;
      }
   }
   
   public void setStartRowIndex() {
      // => (페이지번호 - 1) * (한페이지당 보여줄 글의 갯수)
      this.startRowIndex = (this.pageNo - 1) * this.viewPostCntPerPage;
   }
   
   
   // -- 2차 계산
   public void setPageBlockNoCurPage() {
      // => (현재 페이지 번호) / (1개 페이징 블럭에서 보여줄 페이지 수)
      //                 -> 나누어 떨어지면 몫이 페이지 수가 됨
      //                 -> 나누어 떨어지지 않으면 몫 + 1이 페이지 수가 됨
		if(this.pageNo % this.pageCntPerBlock == 0) {
			this.pageBlockNoCurPage = this.pageNo / this.pageCntPerBlock;
		} else {
			this.pageBlockNoCurPage = this.pageNo / this.pageCntPerBlock + 1; 
		}
   }
   
   public void setStartPageNoCurBlock() {
      // => (현재 페이징 블럭 번호 - 1) * (1개 페이징 블럭에서 보여줄 페이지 수) + 1
      this.startPageNoCurBlock = (this.pageBlockNoCurPage - 1) * this.pageCntPerBlock + 1;
   }
   
   public void setEndPageNoCurBlock() {
      // 2번에서 나온 값(startPageNoCurBlock) + (1개 페이징 블럭에서 보여줄 페이지 수 - 1)
      this.endPageNoCurBlock = this.startPageNoCurBlock + (this.pageCntPerBlock - 1);
      
      // 데이터가 없는 페이지가 나오지 않도록 처리
      if (this.totalPageCnt < this.endPageNoCurBlock) {
         this.endPageNoCurBlock = this.totalPageCnt;
      }
   }

   public void setTotalPageCnt(int totalPostCnt) {
       this.totalPostCnt = totalPostCnt;
       if (this.totalPostCnt > 0 && this.viewPostCntPerPage > 0) {
           this.totalPageCnt = (int) Math.ceil((double) this.totalPostCnt / this.viewPostCntPerPage);
       } else {
           this.totalPageCnt = 0; // 게시물이 없거나 페이지당 게시물 수가 0이면 페이지 수는 0
       }
      
   }
   
}
