package com.biz.grank.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.domain.LikeDto;

public interface BoardService {
	public int countList(Map<String, Object> map);
	public List<BoardDto> listAll(Map<String, Object> map);
	public BoardDto readOne(long bno);
	public void save(BoardDto bDto);
	public void answer(BoardDto bDto);
	public void delete(int bno);
	public void increaseViewCnt(int bno, HttpSession httpSession);
	public void like_cnt_up(int bno);
	public void like_cnt_down(int bno);
	public List<BoardDto> readByWriter(Map<String, Object> map);
	public int countByWriter(String name);
	public List<BoardDto> popularList();
	public void updateWriter(Map<String, String> map);
}
