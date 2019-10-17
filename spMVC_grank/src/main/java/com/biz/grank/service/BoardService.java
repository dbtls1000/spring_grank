package com.biz.grank.service;

import java.util.List;
import java.util.Map;

import com.biz.grank.domain.BoardDto;

public interface BoardService {
	public int countList(Map<String, Object> map);
	public List<BoardDto> listAll(Map<String, Object> map);
	public BoardDto readOne(long bno);
	public void save(BoardDto bDto);
	public void answer(BoardDto bDto);
	public void delete(int bno);
	
}
