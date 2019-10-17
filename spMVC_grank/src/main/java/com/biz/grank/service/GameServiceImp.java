package com.biz.grank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.persistence.GameDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GameServiceImp implements GameService {

	@Autowired
	private GameDao gDao;

	// 1. 출시예정작 리스트 출력
	@Override
	public List<ComingSoonDto> findAll() {
		return gDao.findAll();
	}
}
