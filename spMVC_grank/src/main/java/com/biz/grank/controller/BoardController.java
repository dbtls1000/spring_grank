package com.biz.grank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String write(@RequestParam(defaultValue = "0")int bno, Model model) {
		// bno가 0이 아니면 write.jsp를 수정으로 사용 model에 단건 정보 담기
		if(bno != 0) {
			model.addAttribute("bDto",bService.readOne(bno));
		}
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
		// bno값에 따른 작성/수정
		bService.save(bDto);
		return "redirect:/";
	}
	
	// 게시글 답변 화면단
	@GetMapping("answer")
	public String answer(int bno,Model model) {
		
		model.addAttribute("bDto", bService.readOne(bno));
		// 답변등록일경우 flag에 answer값 담기
		model.addAttribute("flag","answer");
		return "board/write";
	}
	
	@PostMapping("answer")
	public String answer(BoardDto bDto) {
		// 로그인 된 세션값으로부터 작성자이름을 꺼내와 name에 담기
//		String name = (String)httpSession.getAttribute("name");
		// name을 bDto의 b_writer에 담기
//		bDto.setB_writer(name);
		bDto.setB_writer("테스터");
		// 답변을 달고자하는 게시글의 정보를 가져와 ref,re_step,re_level을 set한다
		BoardDto pDto = bService.readOne(bDto.getBno());
		bDto.setRef(pDto.getRef());
		bDto.setRe_step(pDto.getRe_step());
		bDto.setRe_level(pDto.getRe_level());
		
		bService.answer(bDto);
		return "redirect:/";
	}
}
