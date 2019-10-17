package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.ComingSoonDto;

public interface GameService {
	
	public List<ComingSoonDto> findAll();
}	
