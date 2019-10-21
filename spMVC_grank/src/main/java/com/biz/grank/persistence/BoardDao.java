package com.biz.grank.persistence;

import java.util.List;
import java.util.Map;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.domain.LikeDto;

public interface BoardDao {

	public int countList(Map<String, Object> map);

	public List<BoardDto> listAll(Map<String, Object> map);

	public BoardDto readOne(long bno);

	public void insert(BoardDto bDto);

	public void update(BoardDto bDto);

	public void updateRestep(BoardDto bDto);

	public void answer(BoardDto bDto);

	public void delete(int bno);

	public void increaseViewCnt(int bno);

	

}
