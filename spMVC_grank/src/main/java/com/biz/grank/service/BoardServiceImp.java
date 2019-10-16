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
		// TODO list.jsp�� ����� �Խñ� ����
		return bDao.countList();
	}

	@Override
	public List<BoardDto> listAll() {
		// TODO list.jsp�� ����� �Խñ� ����Ʈ
		return bDao.listAll();
	}

	@Override
	public BoardDto readOne(long bno) {
		// view.jsp�� ����� �󼼰Խñ� ����
		return bDao.readOne(bno);
	}
}
