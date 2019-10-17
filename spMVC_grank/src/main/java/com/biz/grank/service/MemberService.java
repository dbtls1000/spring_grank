package com.biz.grank.service;

import javax.servlet.http.HttpSession;

import com.biz.grank.domain.MemberDto;

public interface MemberService {
	public void join(MemberDto mDto);
	public boolean login(MemberDto mDto,HttpSession httpSession);
	public void logout(HttpSession httpSession);
	public MemberDto viewMember(String userid);
	public void update(MemberDto mDto);
}
