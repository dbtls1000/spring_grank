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
		List<ComingSoonDto> clist = gDao.cFindLimit();
		return gDao.cFindAll();
	}


	@Override
	// 2. 출시예정작 n건 출력
	public List<ComingSoonDto> cFindLimit() {
		List<ComingSoonDto> clist = gDao.cFindLimit();
		return gDao.cFindLimit();
	}


	@Override
	public List<GameRankDto> gFindAll(String platform) {
		List<GameRankDto> gList = gDao.gFindAll(platform);
		return gList;
	}

}
