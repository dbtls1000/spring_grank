package com.biz.grank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.service.BoardService;

@Controller
@RequestMapping("board/*")
public class BoardController {
	
	@Autowired
	BoardService bService;
	
	// 게시글 리스트 화면단
	@GetMapping("list")
	public String list(Model model) {
		return "board/list";
	}
	
	// 상세 게시글 화면단
	@GetMapping("view")
	public String view(Model model) {
		return "board/view";
	}
	
	// 게시글작성/수정 화면단
	@GetMapping("write")
	public String write() {
		return "board/write";
	}
	@PostMapping("write")
	public String write(BoardDto bDto) {
		
		
		return "redirect:/";
	}
}
