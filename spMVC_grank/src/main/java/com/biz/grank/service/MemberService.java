package com.biz.grank.service;

import javax.servlet.http.HttpSession;

import com.biz.grank.domain.MemberDto;

public interface MemberService {
	//회원가입
	public void join(MemberDto mDto);
	//로그인
	public void login(MemberDto mDto,HttpSession httpSession);
	//로그아웃
	public void logout(HttpSession httpSession);
	//회원1명의 정보 가져오기
	public MemberDto viewMember(String userid);
}
