package com.biz.grank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.grank.domain.ReplyDto;
import com.biz.grank.service.ReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("reply/*")
public class ReplyController {
	
	@Autowired
	ReplyService rService;
	// 댓글 화면단
	@GetMapping("list")
	public String list(int bno,Model model) {
		model.addAttribute("rList", rService.listAll(bno));
		return "board/commentlist";
	}
	
	// 댓글 작성 Ajax
	@ResponseBody
	@PostMapping("write")
	public void write(ReplyDto rDto,HttpSession httpSession) {
		String name = (String)httpSession.getAttribute("name");
		rDto.setR_writer(name);
		log.info(">>rDto>>" + rDto);
		rService.save(rDto);
	}
	
	// 댓글 삭제 Ajax
	@ResponseBody
	@GetMapping("delete")
	public void delete(ReplyDto rDto) {
		rService.delete(rDto);
	}
}
