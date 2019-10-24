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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.grank.domain.MemberDto;
import com.biz.grank.service.BoardService;
import com.biz.grank.service.MemberService;
import com.biz.grank.service.Pagination;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("member/*")
public class MemberController {
	
	@Autowired
	MemberService mService;
	@Autowired
	BoardService bService;
	
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
	public String mypage(@RequestParam(defaultValue = "1") int curPage,Model model,HttpSession httpSession) {
		// httpSession에서 userid 값 가져오기
		String userid = (String)httpSession.getAttribute("userid");
		String name = (String)httpSession.getAttribute("name");
		int count = bService.countByWriter(name);
		Pagination page = new Pagination(count, curPage);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		Map<String, Object> map = new HashMap<String, Object>();
		log.info("count:"+count+"start:"+start+"end:"+end);
		map.put("name", name);
		map.put("start", start);
		map.put("end", end);
		if(userid == null) {
			// userid 값이 없으면 redirect:/
			return "redirect:/";
		} else {
			// 페이지네이션을하기위해 model에 page담기
			model.addAttribute("page", page);
			// 해당 유저의 작성 게시글을 가져와 model에 담기
			model.addAttribute("bList",bService.readByWriter(map));
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
	// id 찾기 화면단
	@GetMapping("login_check")
	public String login_idcheck(@RequestParam(defaultValue = "idcheck") String code, Model model) {
		model.addAttribute("code",code);
		return "member/login_check";
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
	// id 중복 체크
	@ResponseBody
	@PostMapping("idCheck")
	public int idCheck(String userid) {
		return mService.idCheck(userid);
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
	// 아이디 찾기 이메일 확인 후 아이디 값 가져오기
	@ResponseBody
	@PostMapping("emailcheck")
	public String ajaxEmailCheck(String email) {
		return mService.ajaxEmailCheck(email);
	}
	// 비밀번호 찾기 확인 후 비밀번호 값 가져오기
	@ResponseBody
	@PostMapping("pswordcheck")
	public String ajaxPswordCheck(String userid, String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid",userid);
		map.put("email",email);
		// 아이디와 이메일로 확인 후 값이 있으면 비밀번호 값 가져오기
		String password = mService.ajaxPswordCheck(map);
		String randomps = null;
		// password에 값이 있으면 비밀번호 랜덤 생성 후 비밀번호 변경
		if(password != null) {
			// 비밀번호 랜덤 생성
			randomps = mService.passWordRandom();
			MemberDto mDto = new MemberDto();
			// 비밀번호 변경을 위해 userid 값 담기
			mDto.setUserid(userid);
			// 랜덤 생성한 비밀번호 값 담기
			mDto.setPasswd(randomps);
			// 비밀번호 변경
			mService.psupdate(mDto);
		}
		// 변경된 비밀번호 return
		return randomps;
	}
	// 닉네임 중복 확인
	@ResponseBody
	@PostMapping("namecheck")
	public int ajaxNameCheck(String name) {
		return mService.ajaxNameCheck(name);
	}
}
