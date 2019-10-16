package com.biz.grank.persistence;

import java.util.List;

import com.biz.grank.domain.BoardDto;

public interface BoardDao {

	int countList();

	List<BoardDto> listAll();

	BoardDto readOne(long bno);

}
