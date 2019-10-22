package com.biz.grank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
		int cSize = cList.size();
		model.addAttribute("cSize", cSize);
		return "gameview/comingsoonmoreview";
	}
	
	@RequestMapping(value ="rankmoreview", method = RequestMethod.GET)
	public String RankMoreView(Model model) {
		List<GameRankDto> gList = gameService.gFindAll();
		int gSize = gList.size();
		model.addAttribute("gSize", gSize);
		return "gameview/rankmoreview";
	}
	
	@RequestMapping(value = "rankmoreviewlist", method = RequestMethod.GET)
	public String RankMoreViewList(@RequestParam(defaultValue = "20")int count, Model model) {
		List<GameRankDto> gList = gameService.gMoreView(count);
		model.addAttribute("gList", gList);
		return "gameview/rankmoreviewlist";
	}
	
	@RequestMapping(value = "comingsoonmoreviewlist", method = RequestMethod.GET)
	public String ComingsoonMoreList(@RequestParam(defaultValue = "20")int count, Model model) {
		List<ComingSoonDto> cList = gameService.cMoreView(count);
		model.addAttribute("cList", cList);
		return "gameview/comingsoonmoreviewlist";
		
	}
	
	
	@RequestMapping(value = "platformlist", method = RequestMethod.GET)
	public String PlatformList(Model model) {
		List<GameRankDto> gList = gameService.gFindAll();
		model.addAttribute("gList", gList);
		return "gameview/platformlist";
	}

	

}
