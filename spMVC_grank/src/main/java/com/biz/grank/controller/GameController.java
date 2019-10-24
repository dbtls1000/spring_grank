package com.biz.grank.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.CriticDto;
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
	public String RankMoreView(@RequestParam(defaultValue = "all")String platform,Model model) {
		List<GameRankDto> gList = gameService.gFindPlatform(platform);
		int gSize = gList.size();
		//platform = var platform = '${platform}';로 데이터 받기위해서 보내줌
		model.addAttribute("platform",platform);
		model.addAttribute("gList", gList);
		model.addAttribute("gSize", gSize);
		return "gameview/rankmoreview";
	}
	
	@RequestMapping(value = "rankmoreviewlist", method = RequestMethod.GET)
	public String RankMoreViewList(@RequestParam(defaultValue = "20")int count,
								   @RequestParam(defaultValue = "all")String platform,
								   Model model) {
		Map<String, Object> gMap = new HashMap<String, Object>();
		gMap.put("count", count);
		gMap.put("platform", platform);
		List<GameRankDto> gList = gameService.gMoreView(gMap);
		model.addAttribute("gList", gList);
		return "gameview/rankmoreviewlist";
	}
	
	@RequestMapping(value = "comingsoonmoreviewlist", method = RequestMethod.GET)
	public String ComingsoonMoreList(@RequestParam(defaultValue = "20")int count, Model model) {
		List<ComingSoonDto> cList = gameService.cMoreView(count);
		model.addAttribute("cList", cList);
		return "gameview/comingsoonmoreviewlist";
		
	}
	
	@RequestMapping(value = "gameview", method = RequestMethod.GET)
	public String GameView(@RequestParam String game_code,Model model) {
		log.info(">>게임 코드>>" + game_code);
		List<CriticDto> criticList = gameService.gFindCritic(game_code);
		model.addAttribute("ccList", criticList);
		return "gameview/gameview";
	}

}
