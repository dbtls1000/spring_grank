package com.biz.grank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.GameRankDto;
import com.biz.grank.persistence.GameDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GameServiceImp implements GameService {

	@Autowired
	private GameDao gDao;

	
	@Override
	// 1. 출시예정작 리스트 출력
	public List<ComingSoonDto> cFindAll() {
		List<ComingSoonDto> clist = gDao.cFindAll();
		return gDao.cFindAll();
	}


	@Override
	// 2. 출시예정작 6건 출력
	public List<ComingSoonDto> cFindLimit() {
		List<ComingSoonDto> clist = gDao.cFindLimit();
		return gDao.cFindLimit();
	}

	// 3. 게임평가순위리스트 5건 출력
	@Override
	public List<GameRankDto> gFindLimit(String platform) {
		List<GameRankDto> gList = gDao.gFindLimit(platform);
		return gList;
	}

	// 4. 게임평가순위리스트 모든 건 수 출력
	@Override
	public List<GameRankDto> gFindAll() {
		List<GameRankDto> gList = gDao.gFindAll();
		return gList;
	}

	// 5. 게임평가순위리스트 몇 건만 출력
	@Override
	public List<GameRankDto> gMoreView(int count) {
		List<GameRankDto> gList = gDao.gMoreView(count);
		return gList;
	}

	// 6. 출시예정작 몇 건만 출력
	@Override
	public List<ComingSoonDto> cMoreView(int count) {
		List<ComingSoonDto> cList = gDao.cMoreView(count);
		return cList;
	}



}
