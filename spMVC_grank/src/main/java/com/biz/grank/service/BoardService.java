package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.BoardDto;

public interface BoardService {
	// list.jsp�� ����� �Խñ� ����
	public int countList();
	// list.jsp�� ����� �Խñ� ����Ʈ
	public List<BoardDto> listAll();
	// view.jsp�� ����� �󼼰Խñ� ����
	public BoardDto readOne(long bno);
	
}
