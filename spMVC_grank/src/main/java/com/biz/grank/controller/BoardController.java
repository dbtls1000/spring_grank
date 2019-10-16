package com.biz.grank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("board/*")
public class BoardController {
	
	@Autowired
	BoardService bService;
	
	// 게시글 리스트 화면단
	@GetMapping("list")
	public String list(Model model) {
		// 페이지네이션을 위한 게시글 수
		int count = bService.countList();
		
		model.addAttribute("blist",bService.listAll());
		return "board/list";
	}
	
	// 상세 게시글 화면단
	@GetMapping("view")
	public String view(int bno, Model model) {
		model.addAttribute("bDto", bService.readOne(bno));
		return "board/view";
	}
	
	// 게시글 작성 화면단
	@GetMapping("write")
	public String write() {
		return "board/write";
	}
	
	// 게시글 작성 실행
	@PostMapping("write")
	public String write(BoardDto bDto,HttpSession httpSession) {
		// 로그인 된 세션값으로부터 작성자이름을 꺼내와 name에 담기
//		String name = (String)httpSession.getAttribute("name");
		// name을 bDto의 b_writer에 담기
//		bDto.setB_writer(name);
		bDto.setB_writer("테스터");
		log.info(">>bDto>>"+bDto);
		bService.insert(bDto);
		return "redirect:/";
	}
}
