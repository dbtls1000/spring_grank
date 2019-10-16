package com.biz.grank.persistence;

import java.util.List;

import com.biz.grank.domain.BoardDto;

public interface BoardDao {

	public int countList();

	public List<BoardDto> listAll();

	public BoardDto readOne(long bno);

	public void insert(BoardDto bDto);

}
