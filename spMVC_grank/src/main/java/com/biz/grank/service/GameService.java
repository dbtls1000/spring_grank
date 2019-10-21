package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.GameRankDto;

public interface GameService {
	
	// 1. 출시예정작 리스트 출력
	public List<ComingSoonDto> cFindAll();
	
	// 2. 출시예정작 6건 출력
	public List<ComingSoonDto> cFindLimit();
	
	// 3. 게임순위리스트 5건 출력
	public List<GameRankDto> gFindLimit(String platform);
	
	// 5. 게임순위리스트 모든 건 수 출력
	public List<GameRankDto> gFindAll();
	
}	
