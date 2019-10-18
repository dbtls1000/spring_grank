package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.GameRankDto;

public interface GameService {
	
	// 1. 출시예정작 리스트 출력
	public List<ComingSoonDto> cFindAll();
	
	// 2. 출시예정작 n건 출력
	public List<ComingSoonDto> cFindLimit();
	
	public List<GameRankDto> gFindAll(String platform);
	
}	
