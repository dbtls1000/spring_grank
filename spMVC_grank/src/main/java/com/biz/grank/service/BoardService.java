package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.BoardDto;

public interface BoardService {
	public int countList();
	public List<BoardDto> listAll();
	public BoardDto readOne(long bno);
	public void save(BoardDto bDto);
	public void answer(BoardDto bDto);
	
}
