package com.biz.grank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	// 회원가입 수정 화면단
	@GetMapping("update")
	public String update(Model model,HttpSession httpSession) {
		String userid = (String)httpSession.getAttribute("userid");
		if(userid == null) {
			return "redirect:/";
		} else {
			model.addAttribute("mDto",mService.viewMember(userid));
			return "member/join";
		}
		
		
	}
	// 마이페이지 화면단
	@GetMapping("mypage")
	public String mypage(Model model,HttpSession httpSession) {
		String userid = (String)httpSession.getAttribute("userid");
		model.addAttribute("mDto",mService.viewMember(userid));
		return "member/mypage";
	}
	// 회원가입
	@PostMapping("join")
	public String join(MemberDto mDto) {
		mService.join(mDto);
		
		return "redirect:/";
	}
	
	// 회원 수정
	@PostMapping("update")
	public String update(MemberDto mDto,HttpSession httpSession) {
		String userid = (String)httpSession.getAttribute("userid");
		mDto.setUserid(userid);
		System.out.println(">>>>>>>>>>>>>>>>" + mDto);
		mService.update(mDto);
		return "redirect:/member/mypage";
	}
	// 로그아웃
	@GetMapping("logout")
	public String logout(HttpSession httpSession) {
		mService.logout(httpSession);
		return "redirect:/";
	}
	
	
}
