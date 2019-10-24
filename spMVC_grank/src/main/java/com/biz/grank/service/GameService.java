package com.biz.grank.service;

import java.util.List;
import java.util.Map;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.CriticDto;
import com.biz.grank.domain.GameRankDto;

public interface GameService {
	
	// 1. 출시예정작 리스트 출력
	public List<ComingSoonDto> cFindAll();

	// 2. 출시예정작 6건 출력
	public List<ComingSoonDto> cFindLimit();

	// 3. 게임순위리스트 5건 출력
	public List<GameRankDto> gFindLimit(String platform);

	// 4. 게임순위리스트 사이즈값
	public List<GameRankDto> gFindPlatform(String platform);

	// 5. 게임순위리스트 20건씩 출력
	public List<GameRankDto> gMoreView(Map<String, Object> gMap);

	// 6. 출시예정작 20건씩 출력 
	public List<ComingSoonDto> cMoreView(int count);

	public List<CriticDto> gFindCritic(String game_code);
	
	
}	
