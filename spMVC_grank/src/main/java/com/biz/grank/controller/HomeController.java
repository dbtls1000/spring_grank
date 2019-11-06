package com.biz.grank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.GameRankDto;
import com.biz.grank.service.BoardService;
import com.biz.grank.service.GameService;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	private GameService gameService;
	@Autowired
	private BoardService bService;

	// 1. 출시 예정작 6건 출력
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		// 인기게시글 5건 출력
		List<BoardDto> bList = bService.popularList();
		// 출시 예정작 6건 출력
		List<ComingSoonDto> cList = gameService.cFindLimit();
		
		model.addAttribute("bList", bList);		
		model.addAttribute("cList", cList);
		return "home";
		
	}
	// 2. 게임 순위 리스트 5건 출력
	@RequestMapping(value = "grank", method = RequestMethod.GET)
	public String Grank(Model model, String platform) {
		// 게임 순위 리스트 5건 출력
		List<GameRankDto> gList = gameService.gFindLimit(platform);
		model.addAttribute("gList", gList);
		return "gameview/gameranklist";
	}
	
	@GetMapping("private")
	public String private_info() {
		return "private";
	}
	
}
