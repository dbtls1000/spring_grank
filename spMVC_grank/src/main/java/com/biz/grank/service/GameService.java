package com.biz.grank.service;

import java.util.List;
import java.util.Map;

import com.biz.grank.domain.AwardsRankDto;
import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.CriticDto;
import com.biz.grank.domain.GameRankDto;
import com.biz.grank.domain.UserDto;

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

	// 7. 게임순위리스트 단건 출력
	public GameRankDto gameView(String game_code);

	// 8. Ajax 비평가리뷰 리스트 출력
	public List<CriticDto> gFindCritic(Map<String, Object> criticMap);
	
	// 9. Ajax 유저리뷰 리스트 출력
	public List<UserDto> gFindUser(Map<String, Object> userMap);
	
	// 10. Ajax 비평가 댓글 리스트 
	public int cReviewSize(String game_code);

	// 11. Ajax 유저 댓글 리스트
	public int uReviewSize(String game_code);
	
	// 12. 수상 및 랭킹 리스트
	public AwardsRankDto rFindAll(String game_code);
	
	
}	
