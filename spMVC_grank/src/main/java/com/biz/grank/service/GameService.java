package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.ComingSoonDto;

public interface GameService {
	
	// 1. 출시예정작 리스트 출력
	public List<ComingSoonDto> findAll();
	
	// 2. 출시예정작 n건 출력
	public List<ComingSoonDto> findLimit();
	
}	
