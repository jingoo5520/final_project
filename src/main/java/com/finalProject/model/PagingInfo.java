package com.finalProject.model;

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
	
	public PagingInfo(PagingInfoDTO dto) {
		this.pageNo = dto.getPageNo();
		this.viewPostCntPerPage = dto.getPagingSize();
	}
	
	public void setTotalPostCnt(int totalPostCnt) {
		this.totalPostCnt = totalPostCnt;
	}
	
	public void setTotalPageCnt() {
		if(this.totalPostCnt % this.viewPostCntPerPage == 0) {
			this.totalPageCnt = this.totalPostCnt / this.viewPostCntPerPage;
		} else {
			this.totalPageCnt = (this.totalPostCnt / this.viewPostCntPerPage) + 1; 
		}
	}
	
	public void setStartRowIndex() {
		this.startRowIndex = (this.pageNo - 1) * this.viewPostCntPerPage;
	}
	
	public void setPageBlockNoCurPage() {
		if (this.pageNo % this.pageCntPerBlock == 0) {
			this.pageBlockNoCurPage = this.pageNo / this.pageCntPerBlock;
		} else {
			this.pageBlockNoCurPage = (this.pageNo / this.pageCntPerBlock) + 1;
		}
	}
	
	public void setStartPageNoCurBlock() {
		this.startPageNoCurBlock = (this.pageBlockNoCurPage -1) * this.pageCntPerBlock + 1;
	}

	public void setEndPageNoCurBlock(){
		this.endPageNoCurBlock = this.startPageNoCurBlock + (this.pageCntPerBlock -1);
		
		if(this.totalPageCnt < this.endPageNoCurBlock) {
			this.endPageNoCurBlock = this.totalPageCnt;
		}
	}
}
