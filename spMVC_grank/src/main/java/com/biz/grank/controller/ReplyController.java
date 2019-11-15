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
	public int write(ReplyDto rDto,HttpSession httpSession) {
		// 세션에 저장된 name값 가져오기
		String name = (String)httpSession.getAttribute("name");
		rDto.setR_writer(name);
		log.info(">>rDto>>" + rDto);
		// 댓글 등록/수정
		rService.save(rDto);
		// 해당 게시글의 총 댓글 수
		int bno = rDto.getBno();
		log.info(">>>>"+rService.countReply(bno));
		return rService.countReply(bno);
	}
	
	// 댓글 삭제 Ajax
	@ResponseBody
	@GetMapping("delete")
	public int delete(ReplyDto rDto) {
		// 댓글 삭제
		rService.delete(rDto);
		// 해당 게시글의 총 댓글 수
		int bno = rDto.getBno();
		return rService.countReply(bno);
	}
}
