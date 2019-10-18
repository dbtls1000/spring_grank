package com.biz.grank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.biz.grank.service.ReplyService;

@Controller
@RequestMapping("reply/*")
public class ReplyController {
	
	@Autowired
	ReplyService rService;
	// 댓글 화면단
	@GetMapping
	public String list(int bno,Model model) {
		model.addAttribute("rList", rService.listAll(bno));
		return "board/commentlist";
	}
	
}
