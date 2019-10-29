package com.biz.grank.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.biz.grank.domain.AwardsRankDto;
import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.CriticDto;
import com.biz.grank.domain.GameRankDto;
import com.biz.grank.domain.UserDto;
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
	
	@RequestMapping(value = "comingsoonmoreviewlist", method = RequestMethod.GET)
	public String ComingsoonMoreList(@RequestParam(defaultValue = "20")int count, Model model) {
		List<ComingSoonDto> cList = gameService.cMoreView(count);
		model.addAttribute("cList", cList);
		return "gameview/comingsoonmoreviewlist";
		
	}
	
	@RequestMapping(value ="rankmoreview", method = RequestMethod.GET)
	public String RankMoreView(@RequestParam(defaultValue = "all")String platform,Model model) {
		List<GameRankDto> gList = gameService.gFindPlatform(platform);
		log.info(">>>>>platform>>>>"+platform);
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
		// 20개씩 출력하기 위한 변수
		gMap.put("count", count);
		// 게임 종류별로 클릭시 정렬하기 위한 변수
		gMap.put("platform", platform);
		List<GameRankDto> gList = gameService.gMoreView(gMap);
		log.info("gList >>>>>>>>>>>>>>>>>>" + gList);
		model.addAttribute("gList", gList);
		return "gameview/rankmoreviewlist";
	}
	
	@RequestMapping(value = "gameview", method = RequestMethod.GET)
	public String gameView(@RequestParam String game_code, Model model) {
		GameRankDto gDto = gameService.gameView(game_code);
		int cSize = gameService.cReviewSize(game_code);
		int uSize = gameService.uReviewSize(game_code);
		AwardsRankDto rDto = gameService.rFindAll(game_code);
		List<String> rList = rDto.getAwardslist();
		model.addAttribute("csize", cSize);
		model.addAttribute("usize", uSize);
		model.addAttribute("rList", rList);
		model.addAttribute("gDto", gDto);
		return "gameview/gameview";
	}
	
	@RequestMapping(value = "creview", method = RequestMethod.GET)
	public String cReview(@RequestParam String game_code,
			 			  @RequestParam(defaultValue = "5") int count,
						  Model model) {
		Map<String, Object>	criticMap = new HashMap<String, Object>();
		criticMap.put("game_code", game_code);
		criticMap.put("count", count);
		List<CriticDto> criticList = gameService.gFindCritic(criticMap);
		model.addAttribute("ccList", criticList);
		return "gameview/creview";
	}
	
	@RequestMapping(value = "ureview", method = RequestMethod.GET)
	public String uReveiw(@RequestParam String game_code, 
			 			  @RequestParam(defaultValue = "5")int count,
							Model model) {
		Map<String, Object> userMap = new HashMap<String, Object>();
		userMap.put("game_code", game_code);
		userMap.put("count", count);
		List<UserDto> userList = gameService.gFindUser(userMap);
		model.addAttribute("userList", userList);
		return "gameview/ureview";
	}
	
	@GetMapping("search")
	public String searchGame(@RequestParam(defaultValue = "")String keyword,Model model) {
		List<GameRankDto> gList = gameService.gSearchList(keyword);
		model.addAttribute("gList",gList);
		return "gameview/search-result";
	}

}
