package com.biz.grank.service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.MemberDto;
import com.biz.grank.persistence.MemberDao;

@Service
public class MemberServiceImp implements MemberService {
	@Inject
	SqlSession sqlSession;
	
	MemberDao mDao;
	
	@Inject
	BCryptPasswordEncoder passwordEncoder;
	
	@Inject
	public void getMapper() {
		mDao = sqlSession.getMapper(MemberDao.class);
	}

	@Override
	public void join(MemberDto mDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void login(MemberDto mDto, HttpSession httpSession) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void logout(HttpSession httpSession) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberDto viewMember(String userid) {
		// TODO Auto-generated method stub
		return null;
	}
}
