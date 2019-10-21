package com.biz.grank.controller;

import java.util.HashMap;
import java.util.Map;

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
		// httpSession에서 userid 값 가져오기
		String userid = (String)httpSession.getAttribute("userid");
		if(userid == null) {
			// userid 값이 없으면 redirect:/
			return "redirect:/";
		} else {
			// userid 값이 있으면 model에 userid 값과 일치한 값 담기
			model.addAttribute("mDto",mService.viewMember(userid));
			return "member/join";
		}
		
		
	}
	// 마이페이지 화면단
	@GetMapping("mypage")
	public String mypage(Model model,HttpSession httpSession) {
		// httpSession에서 userid 값 가져오기
		String userid = (String)httpSession.getAttribute("userid");
		if(userid == null) {
			// userid 값이 없으면 redirect:/
			return "redirect:/";
		} else {
			// userid 값이 있으면 model에 userid 값과 일치한 값 담기
			model.addAttribute("mDto",mService.viewMember(userid));
			return "member/mypage";
		}
	}
	// 비밀번호 변경 화면단
	@GetMapping("member_password")
	public String member_password() {
		return "member/password";
	}
	// 회원탈퇴 화면단
	@GetMapping("member_delete")
	public String member_delete() {
		return "member/member_delete";
	}
	// 회원가입
	@PostMapping("join")
	public String join(MemberDto mDto) {
		mService.join(mDto);
		
		return "redirect:/";
	}
	
	// 회원 수정
	@PostMapping("update")
	public String update(MemberDto mDto,HttpSession httpSession,Model model) {
		String userid = (String)httpSession.getAttribute("userid");
		mDto.setUserid(userid);
		mService.update(mDto);
		// 회원 수정 후 model에 값 담기
		model.addAttribute("mDto",mDto);
		return "redirect:/member/mypage";
	}
	
	// 회원 탈퇴
	@PostMapping("delete")
	public String delete(String userid ,HttpSession httpSession) {
		mService.delete(userid);
		// 회원 탈퇴 후 로그아웃
		mService.logout(httpSession);
		return "redirect:/";
	}
	// 로그아웃
	@ResponseBody
	@GetMapping("logout")
	public void logout(HttpSession httpSession) {
		mService.logout(httpSession);
	}
	// 비밀번호 변경
	@PostMapping("psupdate")
	public String psupdate(MemberDto mDto,Model model) {
		mService.psupdate(mDto);
		// 비밀번호 변경후 mDto에서 userid 값 가져오기
		String userid = mDto.getUserid();
		// userid와 일치한 데이터 가져와 view에 담기
		MemberDto view = mService.viewMember(userid);
		model.addAttribute("mDto",view);
		return "redirect:/member/mypage";
	}
	// 회원 탈퇴 비밀번호 확인
	@ResponseBody
	@PostMapping("passCheck")
	public int passCheck(String userid, String passwd) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid",userid);
		map.put("passwd",passwd);
		return mService.passCheck(map);
	}
}
