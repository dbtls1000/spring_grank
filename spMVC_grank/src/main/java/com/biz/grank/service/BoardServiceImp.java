package com.biz.grank.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.persistence.BoardDao;

@Service
public class BoardServiceImp implements BoardService {
	@Inject
	SqlSession sqlSession;
	
	BoardDao bDao;
	
	@Inject
	public void getMapper() {
		bDao = sqlSession.getMapper(BoardDao.class);
	}

	@Override
	public int countList() {
		// TODO list.jsp에 출력할 게시글 개수
		return bDao.countList();
	}

	@Override
	public List<BoardDto> listAll() {
		// TODO list.jsp에 출력할 게시글 리스트
		return bDao.listAll();
	}

	@Override
	public BoardDto readOne(long bno) {
		// view.jsp에 출력할 상세게시글 정보
		return bDao.readOne(bno);
	}
}
