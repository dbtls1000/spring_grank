package com.biz.grank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.GameRankDto;
import com.biz.grank.service.GameService;

import lombok.extern.slf4j.Slf4j;

// https://github.com/dbtls1000/spring_grank

@Slf4j
@RequestMapping("game/*")
@Controller
public class GameController {

	@Autowired
	private GameService gameService;


	@RequestMapping(value = "comingsoonmoreview", method = RequestMethod.GET)
	public String ComingsoonMore(Model model) {
		List<ComingSoonDto> cList = gameService.cFindAll();
		model.addAttribute("cList", cList);
		return "gameview/comingsoonmoreview";
	}
	
	@RequestMapping(value ="rankmoreview", method = RequestMethod.GET)
	public String MankMoreview(Model model) {
		List<GameRankDto> gList = gameService.gFindAll();
		model.addAttribute("gList", gList);
		return "gameview/rankmoreview";
	}
	

}
