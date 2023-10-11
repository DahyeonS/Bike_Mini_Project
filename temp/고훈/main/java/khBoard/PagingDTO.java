package khBoard;

public class PagingDTO {

	int totalCount, listNum, blockNum, pageNum;
	int totalPage, startPage, endPage;

	boolean isPrev, isNext, isBPrev, isBNext;

	public PagingDTO(int totalCount, int pageNum, int blockNum, int listNum) {
		super();
		this.totalCount = totalCount;
		this.listNum = listNum;
		this.blockNum = blockNum;
		this.pageNum = pageNum;
	}
	
	public void setPaging(){

		totalPage = (int)Math.ceil((double)totalCount/listNum);

		// 시작, 끝 페이지 
		// 1 ~ 10 => 1, 11 ~ 20 => 11, 21 ~ 30 => 21
		startPage = ((pageNum-1) / blockNum) * blockNum + 1;
		endPage = startPage + blockNum -1;
		if(endPage > totalPage) endPage = totalPage;

		// isBPrev, isBNext
		isBPrev = startPage > 1;
		isBNext = totalPage > endPage; 

		//isPrev, isNext
		isPrev = pageNum > 1;
		isNext = pageNum < totalPage; 
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getListNum() {
		return listNum;
	}

	public int getBlockNum() {
		return blockNum;
	}

	public int getPageNum() {
		return pageNum;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean getIsPrev() {
		return isPrev;
	}

	public boolean getIsNext() {
		return isNext;
	}

	public boolean getIsBPrev() {
		return isBPrev;
	}

	public boolean getIsBNext() {
		return isBNext;
	}

	@Override
	public String toString() {
		return "PagingDTO [totalCount=" + totalCount + ", listNum=" + listNum + ", blockNum=" + blockNum + ", pageNum="
				+ pageNum + ", totalPage=" + totalPage + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", isPrev=" + isPrev + ", isNext=" + isNext + ", isBPrev=" + isBPrev + ", isBNext=" + isBNext + "]";
	}
	
	
	
	
	
}
