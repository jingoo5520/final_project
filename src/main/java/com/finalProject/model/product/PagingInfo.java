package com.finalProject.model.product;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PagingInfo {

    private int pageNo; 
    private int viewPostCntPerPage; 
    
    private int totalPostCnt; 
    private int totalPageCnt; 
    private int startRowIndex; 
    
    private int pageCntPerBlock = 10; 
    private int pageBlockNoCurPage; 
    private int startPageNoCurBlock; 
    private int endPageNoCurBlock; 
    
    public PagingInfo(PagingInfoDTO dto, int totalPostCnt) {
        this.pageNo = dto.getPageNo();
        this.viewPostCntPerPage = dto.getPagingSize();
        this.totalPostCnt = totalPostCnt;
        
        // 전체 페이지 수 계산
        setTotalPageCnt();
        // 시작 인덱스 계산
        setStartRowIndex();
        // 현재 페이지가 속한 블록 번호 계산
        setPageBlockNoCurPage();
        // 현재 블록의 시작 페이지 번호 계산
        setStartPageNoCurBlock();
        // 현재 블록의 끝 페이지 번호 계산
        setEndPageNoCurBlock();
    }
    
    private void setTotalPageCnt() {
        this.totalPageCnt = (this.totalPostCnt + this.viewPostCntPerPage - 1) / this.viewPostCntPerPage;
    }

    private void setStartRowIndex() {
        this.startRowIndex = (this.pageNo - 1) * this.viewPostCntPerPage;
    }
    
    private void setPageBlockNoCurPage() {
        this.pageBlockNoCurPage = (this.pageNo + this.pageCntPerBlock - 1) / this.pageCntPerBlock;
    }
    
    private void setStartPageNoCurBlock() {
        this.startPageNoCurBlock = (this.pageBlockNoCurPage - 1) * this.pageCntPerBlock + 1;
    }

    private void setEndPageNoCurBlock() {
        this.endPageNoCurBlock = Math.min(this.startPageNoCurBlock + this.pageCntPerBlock - 1, this.totalPageCnt);
    }
}
