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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	// 출시예정작 View단(껍다구)
	@RequestMapping(value = "comingsoonmoreview", method = RequestMethod.GET)
	public String ComingsoonMore(Model model) {
		List<ComingSoonDto> cList = gameService.cFindAll(); 
		int cSize = cList.size();
		model.addAttribute("cSize", cSize);
		return "gameview/comingsoonmoreview";
	}
	
	// 출시예정작 20개씩 늘려가며 보여주는 첨부용 View단(Ajax)
	@RequestMapping(value = "comingsoonmoreviewlist", method = RequestMethod.GET)
	public String ComingsoonMoreList(@RequestParam(defaultValue = "20")int count, Model model) {
		List<ComingSoonDto> cList = gameService.cMoreView(count);
		model.addAttribute("cList", cList);
		return "gameview/comingsoonmoreviewlist";
	}
	
	// 게임순위 View단(껍데기)
	@RequestMapping(value ="rankmoreview", method = RequestMethod.GET)
	public String RankMoreView(@RequestParam(defaultValue = "All")String platform,Model model) {
//		model.addAttribute("platform",platform);
		return "gameview/rankmoreview";
	}
	
	@RequestMapping(value="redirectpage")
	public String redirectPage(RedirectAttributes redirectAttributes,String platform) {
		redirectAttributes.addFlashAttribute("platform",platform);
		return "redirect:/game/rankmoreview";
	}
	
	
	// 게임순위 20개씩 늘려가며 보여주는 첨부용 View단(Ajax)
	@RequestMapping(value = "rankmoreviewlist", method = RequestMethod.GET)
	public String RankMoreViewList(@RequestParam(defaultValue = "20")int count,
								   @RequestParam(defaultValue = "All")String platform,
								   Model model) {
		int gSize = gameService.gFindPlatform(platform).size();
		Map<String, Object> gMap = new HashMap<String, Object>();
		// 20개씩 출력하기 위한 변수
		gMap.put("count", count);
		// 게임 종류별로 클릭시 정렬하기 위한 변수
		gMap.put("platform", platform);
		List<GameRankDto> gList = gameService.gMoreView(gMap);
		model.addAttribute("gList", gList);
		model.addAttribute("gSize",gSize);
		return "gameview/rankmoreviewlist";
	}
	
	// 게임 상세 정보 View단
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
	
	// 비평가 댓글 첨부 View(Ajax)
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

	// 유저 댓글 첨부 View(Ajax)
	@RequestMapping(value = "ureview", method = RequestMethod.GET)
	public String uReveiw(@RequestParam String game_code, 
			 			  @RequestParam(defaultValue = "5")int count,
							Model model) {
		Map<String, Object> userMap = new HashMap<String, Object>();
		userMap.put("game_code", game_code);
		userMap.put("count", count);
		List<UserDto> userList = gameService.gFindUser(userMap);
		model.addAttribute("uSize", userList.size());
		model.addAttribute("userList", userList);
		return "gameview/ureview";
	}
	
	// 게임 검색 첨부 View(Ajax)
	@GetMapping("search")
	public String searchGame(@RequestParam(defaultValue = "")String keyword,Model model) {
		List<GameRankDto> gList = gameService.gSearchList(keyword);
		for (GameRankDto gameRankDto : gList) {
			String indexname = gameRankDto.getGame_name().toLowerCase();
			String name = gameRankDto.getGame_name();
			int index = indexname.indexOf(keyword.toLowerCase());
			String indexkeyword = name.substring(index, index+keyword.length());
			log.info(">>>>>>>>>>>>>>"+indexkeyword);
			if(name.contains(keyword)) {
				gameRankDto.setGame_name(gameRankDto.getGame_name()
							.replace(keyword, "<span style='color:#e55039;font-weight:bold;'>"+keyword+"</span>"));
			} else {
				gameRankDto.setGame_name(gameRankDto.getGame_name()
						.replace(indexkeyword, "<span style='color:#e55039;font-weight:bold;'>"+indexkeyword+"</span>"));
			}
		}
		// 대문자 검색 안됨 ㅎ
		model.addAttribute("gList",gList);
		return "gameview/search-result";
	}

}
