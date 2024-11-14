package com.finalProject.model.product;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PagingInfo {

    private int currentPage; // 현재 페이지 번호 (기존: pageNo)
    private int pageSize; // 한 페이지에 보여줄 게시물 수 (기존: viewPostCntPerPage)
    
    private int totalProductCount; // 전체 게시물 수 (기존: totalPostCnt)
    private int totalPages; // 전체 페이지 수 (기존: totalPageCnt)
    private int startRowIndex; // 시작 인덱스 (DB 조회 시 시작 위치)
    
    private int pageBlockSize = 10; // 한 화면에 보여줄 페이지 수 (예: 10페이지씩)
    private int currentBlock; // 현재 페이지가 속한 블록 번호 (기존: pageBlockNoCurPage)
    private int startPage; // 현재 블록의 시작 페이지 번호 (기존: startPageNoCurBlock)
    private int endPage; // 현재 블록의 마지막 페이지 번호 (기존: endPageNoCurBlock)
    
    public PagingInfo(PagingInfoDTO dto, int totalProductCount) {
        this.currentPage = dto.getPageNo();
        this.pageSize = dto.getPageSize();
        this.totalProductCount = totalProductCount;
        
        // 전체 페이지 수 계산
        setTotalPages();
        // 시작 인덱스 계산
        setStartRowIndex();
        // 현재 페이지가 속한 블록 번호 계산
        setCurrentBlock();
        // 현재 블록의 시작 페이지 번호 계산
        setStartPage();
        // 현재 블록의 마지막 페이지 번호 계산
        setEndPage();
    }
    
    private void setTotalPages() {
        this.totalPages = (this.totalProductCount + this.pageSize - 1) / this.pageSize;
    }

    private void setStartRowIndex() {
        this.startRowIndex = (this.currentPage - 1) * this.pageSize;
    }
    
    private void setCurrentBlock() {
        this.currentBlock = (this.currentPage + this.pageBlockSize - 1) / this.pageBlockSize;
    }
    
    private void setStartPage() {
        this.startPage = (this.currentBlock - 1) * this.pageBlockSize + 1;
        if (this.startPage < 1) {
            this.startPage = 1;
        }
    }

    private void setEndPage() {
        this.endPage = Math.min(this.startPage + this.pageBlockSize - 1, this.totalPages);
    }
    
    // 이전 블록이 존재하는지 여부 반환
    public boolean hasPrevBlock() {
        return this.currentBlock > 1;
    }

    // 다음 블록이 존재하는지 여부 반환
    public boolean hasNextBlock() {
        return this.endPage < this.totalPages;
    }
}
