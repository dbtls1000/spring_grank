package com.biz.grank.service;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.MemberDto;
import com.biz.grank.persistence.MemberDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
		String strPassword = mDto.getPasswd();
		// crypt text : 암호와된 문자열
		String cryptPassword = passwordEncoder.encode(strPassword);
		mDto.setPasswd(cryptPassword);

		mDao.join(mDto);
	}

	@Override
	public boolean login(MemberDto mDto, HttpSession httpSession) {
		// TODO 로그인
		// 입력한 아이디와 맞는 값이 있으면 checkDto에 담기
		MemberDto checkDto = mDao.loginCheck(mDto);
		boolean result = false;
		if (checkDto.getUserid() != null) {
			// 입력한 아이디로 가져온 정보의 암호화된 비밀번호
			String cryptPassword = checkDto.getPasswd();
			// 입력한 비밀번호
			String strPassword = mDto.getPasswd();
			// 위에 두 비밀번호가 같은지 비교
			if (passwordEncoder.matches(strPassword, cryptPassword)) {
				// 같으면 result에 true담기
				result = true;
			} else {
				// 다르면 false 담기
				result = false;
			}
		}

		// result가 1이면 로그인 성공
		if (result) {
			// 로그인한 아이디값으로 mDto를 가져와 세션에 userid와 name값 담기
			MemberDto user = viewMember(mDto.getUserid());
			httpSession.setAttribute("userid", user.getUserid());
			httpSession.setAttribute("name", user.getName());
		}
		return result;
	}

	@Override
	public void logout(HttpSession httpSession) {
		// TODO 로그아웃
		httpSession.invalidate();
	}

	@Override
	public MemberDto viewMember(String userid) {
		// TODO 회원 1명 정보 조회
		return mDao.viewMember(userid);
	}

	@Override
	public void update(MemberDto mDto) {
		// TODO 회원 수정
		mDao.update(mDto);
	}

	@Override
	public int passCheck(Map<String, Object> map) {
		// TODO 회원 탈퇴 확인
		// map에서 userid 값 가져오기
		String userid = (String)map.get("userid");
		// userid 값으로 맞는 데이터가 있으면 checkDto에 담기
		MemberDto checkDto= mDao.viewMember(userid);
		int result = 0;
		if(checkDto.getUserid() != null) {
			// checkDto에서 passwd 값 가져와 cryptPassword에 담기
			String cryptPassword = checkDto.getPasswd();
			// map에서 passwd 값 가져와서 String 타입으로 strPassword 담기
			String strPassword = (String)map.get("passwd");
			if(passwordEncoder.matches(strPassword, cryptPassword)) {
				// 값이 일치하면 map에 cryptPassword 값 담기
				map.put("passwd",cryptPassword);
				// map에 담긴 값으로 체크
				result = mDao.passCheck(map);
			} else {
				result = 0;
			}
		}
		
		return result;
	}

	@Override
	public void delete(String userid) {
		// TODO 회원 탈퇴
		mDao.delete(userid);
	}

	@Override
	public void psupdate(MemberDto mDto) {
		// TODO 비밀번호 변경
		String strPassword = mDto.getPasswd();
		// 암호화 된 문자로 변경
		String cryptPassword = passwordEncoder.encode(strPassword);
		mDto.setPasswd(cryptPassword);
		mDao.psupdate(mDto);
	}


}
