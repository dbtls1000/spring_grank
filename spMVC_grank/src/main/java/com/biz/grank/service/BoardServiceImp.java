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
		// TODO 게시글 리스트 개수
		return bDao.countList();
	}

	@Override
	public List<BoardDto> listAll() {
		// TODO 게시글 리스트 가져옴
		return bDao.listAll();
	}

	@Override
	public BoardDto readOne(long bno) {
		// 게시글 단건의 정보 가져옴
		return bDao.readOne(bno);
	}
}
