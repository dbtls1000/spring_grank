package com.biz.grank.service;

import javax.servlet.http.HttpSession;

import com.biz.grank.domain.MemberDto;

public interface MemberService {
	//ȸ������
	public void join(MemberDto mDto);
	//�α���
	public void login(MemberDto mDto,HttpSession httpSession);
	//�α׾ƿ�
	public void logout(HttpSession httpSession);
	//ȸ��1���� ���� ��������
	public MemberDto viewMember(String userid);
}
