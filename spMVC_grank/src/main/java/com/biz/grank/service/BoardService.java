package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.BoardDto;

public interface BoardService {
	public int countList();
	public List<BoardDto> listAll();
	public BoardDto readOne(long bno);
	
}
