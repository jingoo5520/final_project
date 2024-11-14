package com.finalProject.model.review;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReviewPagingInfo {

    private int currentPage; // 현재 페이지 번호
    private int pageSize; // 한 페이지당 보여줄 게시물 수
    
    private int totalPostCount; // 전체 게시물 수
    private int totalPages; // 전체 페이지 수
    private int startRowIndex; // 시작 인덱스 (DB 조회를 위한 시작 위치)
    
    private int pageBlockSize = 10; // 한 페이지 블록에 보여줄 페이지 수 (예: 3페이지씩)
    private int currentBlock; // 현재 페이지가 속한 블록 번호
    private int startPage; // 현재 블록의 시작 페이지 번호
    private int endPage; // 현재 블록의 끝 페이지 번호
    
    public ReviewPagingInfo(ReviewPagingInfoDTO dto, int totalPostCount) {
        this.currentPage = dto.getPageNo() > 0 ? dto.getPageNo() : 1; // 기본값: 1
        this.pageSize = dto.getPageSize() > 0 ? dto.getPageSize() : 10; // 기본값: 10
        this.totalPostCount = totalPostCount;
        
        // 전체 페이지 수 계산
        setTotalPages();
        // 시작 인덱스 계산
        setStartRowIndex();
        // 현재 페이지가 속한 블록 번호 계산
        setCurrentBlock();
        // 현재 블록의 시작 페이지 번호 계산
        setStartPage();
        // 현재 블록의 끝 페이지 번호 계산
        setEndPage();
    }
    
    private void setTotalPages() {
        this.totalPages = (int) Math.ceil((double) totalPostCount / pageSize);
    }

    private void setStartRowIndex() {
        this.startRowIndex = (currentPage - 1) * pageSize;
    }
    
    private void setCurrentBlock() {
        this.currentBlock = (currentPage + pageBlockSize - 1) / pageBlockSize;
    }
    
    private void setStartPage() {
        this.startPage = (currentBlock - 1) * pageBlockSize + 1;
        if (this.startPage < 1) {
            this.startPage = 1;
        }
    }

    private void setEndPage() {
        this.endPage = Math.min(this.startPage + pageBlockSize - 1, this.totalPages);
    }
    
    // 현재 블록의 이전 블록이 있는지 여부 반환
    public boolean hasPrevBlock() {
        return this.currentBlock > 1;
    }

    // 현재 블록의 다음 블록이 있는지 여부 반환
    public boolean hasNextBlock() {
        return this.endPage < this.totalPages;
    }
}
