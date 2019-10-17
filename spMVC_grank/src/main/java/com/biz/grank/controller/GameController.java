package com.biz.grank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.service.GameService;

import lombok.extern.slf4j.Slf4j;


// https://github.com/dbtls1000/spring_grank

@Slf4j
@RequestMapping("game/*")
@Controller
public class GameController {
	
	@Autowired
	private GameService gameService;

	// 출시 예정작 리스트 불러오기
	@RequestMapping(value = "commingsoon", method = RequestMethod.GET)
	public String commingSoon() {
		List<ComingSoonDto> cList = gameService.findAll();
		log.info("cList : ", cList);
		return "home";
		
	}
}
