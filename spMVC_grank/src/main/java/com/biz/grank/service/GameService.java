package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.ComingSoonDto;

public interface GameService {
	
	// 출시예정장 리스트 출력
	public List<ComingSoonDto> findAll();
	
}	
