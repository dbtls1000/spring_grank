package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.BoardDto;

public interface BoardService {
	// list.jsp에 출력할 게시글 개수
	public int countList();
	// list.jsp에 출력할 게시글 리스트
	public List<BoardDto> listAll();
	// view.jsp에 출력할 상세게시글 정보
	public BoardDto readOne(long bno);
	
}
