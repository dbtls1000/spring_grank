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
	
	// 비밀번호 암호화
	@Inject
	BCryptPasswordEncoder passwordEncoder;
	
	@Inject
	public void getMapper() {
		mDao = sqlSession.getMapper(MemberDao.class);
	}

	@Override
	public void join(MemberDto mDto) {
		// TODO 회원가입
		
	}

	@Override
	public void login(MemberDto mDto, HttpSession httpSession) {
		// TODO 로그인
		
	}

	@Override
	public void logout(HttpSession httpSession) {
		// TODO 로그아웃
		
	}

	@Override
	public MemberDto viewMember(String userid) {
		// TODO 회원 1명 정보 조회
		return null;
	}
}
