package com.biz.grank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("member/*")
public class MemberController {
	
	// 회원가입 화면단
	@GetMapping("join")
	public String join() {
		return "member/join";
	}
}
