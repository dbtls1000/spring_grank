package com.biz.grank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.grank.domain.MemberDto;
import com.biz.grank.service.MemberService;

@Controller
@RequestMapping("member/*")
public class MemberController {
	
	@Autowired
	MemberService mService;
	
	// 로그인
	@ResponseBody
	@PostMapping("login")
	public String login(MemberDto mDto, HttpSession httpSession) {
		boolean result = mService.login(mDto, httpSession);
		String flag ="-1";
		if(result) {
			flag ="1";
		}
		
		return flag;
	}
	
	
	// 회원가입 화면단
	@GetMapping("join")
	public String join() {
		return "member/join";
	}
	
	// 회원가입
	@PostMapping("join")
	public String join(MemberDto mDto) {
		System.out.println(mDto);
		mService.join(mDto);
		
		return "redirect:/";
	}
	
	@GetMapping("logout")
	public String logout(HttpSession httpSession) {
		mService.logout(httpSession);
		return "redirect:/";
	}
}
