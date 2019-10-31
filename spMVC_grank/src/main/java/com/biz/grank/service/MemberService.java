package com.biz.grank.service;

import java.sql.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.biz.grank.domain.MemberDto;

public interface MemberService {
	public void join(MemberDto mDto);
	public boolean login(MemberDto mDto,HttpSession httpSession);
	public void logout(HttpSession httpSession);
	public MemberDto viewMember(String userid);
	public void update(MemberDto mDto);
	public int passCheck(Map<String, Object> map);
	public void delete(String userid);
	public void psupdate(MemberDto mDto);
	public int idCheck(String userid);
	public String ajaxEmailCheck(String email);
	public String ajaxPswordCheck(Map<String, Object> map);
	public String passWordRandom();
	public int ajaxNameCheck(String name);
	public MemberDto checkUserWithSessionKey(Map<String, Object> map);
	public void autoLoginCheck(MemberDto mDto);
	public boolean emailOverlapCheck(String email);
}
