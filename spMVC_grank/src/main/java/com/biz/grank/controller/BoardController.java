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
	
	// �Խñ� ����Ʈ ȭ���
	@GetMapping("list")
	public String list(Model model) {
		return "board/list";
	}
	
	// �� �Խñ� ȭ���
	@GetMapping("view")
	public String view(Model model) {
		return "board/view";
	}
	
	// �Խñ��ۼ�/���� ȭ���
	@GetMapping("write")
	public String write() {
		return "board/write";
	}
	@PostMapping("write")
	public String write(BoardDto bDto) {
		
		
		return "redirect:/";
	}
}
