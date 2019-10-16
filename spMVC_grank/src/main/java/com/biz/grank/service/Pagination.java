package com.biz.grank.service;

public class Pagination {
	public static final int PAGE_SCALE = 10; // �������� �Խù� ��
	public static final int BLOCK_SCALE = 10; // ȭ��� ��������

	private int curPage; // ���� ������
	private int prevPage; // ���� ������
	private int nextPage; // ���� ������
	private int totalPage; // ��ü ������ ����
	private int totalBlock; // ��ü ������ ��ϰ���
	private int curBlock; // ������
	private int prevBlock; // �������
	private int nextBlock; // �������
	private int pageBegin; // #{start}��
	private int pageEnd; // #{end}��
	private int blockBegin; // ����� ���������� ��ȣ
	private int blockEnd; // ����� �������� ��ȣ

	// Pager(���ڵ尳��,�������������ȣ)
	public Pagination(int count, int curPage) {
		curBlock = 1; // �����Ϲ�ȣ
		this.curPage = curPage; // ���� ������ ��ȣ
		setTotalPage(count); // ��ü ������ ���� ���
		setPageRange(); // #{start}#{end}�� ���
		setTotalBlock(); // ��ü ��� ���� ���
		setBlockRange(); // ����� ����,�� ��ȣ ���
	}

	public void setPageRange() {
		// ���۹�ȣ = (����������-1)x�������� �Խù��� +1
		// ����ȣ = ���۹�ȣ +�������� �Խù��� -1
		pageBegin = (curPage - 1) * PAGE_SCALE + 1;
		pageEnd = pageBegin + PAGE_SCALE - 1;
	}
	public void setTotalBlock() {
		totalBlock = (int)Math.ceil(totalPage*1.0/BLOCK_SCALE);
	}
	// ����� ���� ���
	public void setBlockRange() {
		// ���ϴ��������� ���° ��Ͽ� ���ϴ��� ���
		curBlock = (curPage - 1) / BLOCK_SCALE + 1;
		// ����� ���������� �������� ��ȣ ���
		blockBegin = (curBlock - 1) * BLOCK_SCALE + 1;
		blockEnd = blockBegin + BLOCK_SCALE - 1;
		// ��������� ��ȣ�� ������ �ʰ����� �ʵ��� ó��
		if (blockEnd > totalPage) {
			blockEnd = totalPage;
		}
		// [����] [����]�� �������� �̵��� ������ ��ȣ
		prevPage = (curBlock == 1) ? 1 : (curBlock - 1) * BLOCK_SCALE;
		nextPage = curBlock > totalBlock ? (curBlock * BLOCK_SCALE) : (curBlock * BLOCK_SCALE) + 1;
		// ������ �������� ������ �ʰ����� �ʵ��� ó��
		if(nextPage >= totalPage) {
			nextPage = totalPage;
		}

	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int count) {
		//Math.ceil()�ø�
		totalPage = (int)Math.ceil(count*1.0/PAGE_SCALE);
	}

	public int getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockBegin() {
		return blockBegin;
	}

	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}

	public static int getPageScale() {
		return PAGE_SCALE;
	}

	public static int getBlockScale() {
		return BLOCK_SCALE;
	}

	@Override
	public String toString() {
		return "Pager [curPage=" + curPage + ", prevPage=" + prevPage + ", nextPage=" + nextPage + ", totalPage="
				+ totalPage + ", totalBlock=" + totalBlock + ", curBlock=" + curBlock + ", prevBlock=" + prevBlock
				+ ", nextBlock=" + nextBlock + ", pageBegin=" + pageBegin + ", pageEnd=" + pageEnd + ", blockBegin="
				+ blockBegin + ", blockEnd=" + blockEnd + "]";
	}
}
