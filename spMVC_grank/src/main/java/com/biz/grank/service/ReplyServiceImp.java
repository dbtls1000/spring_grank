package com.biz.grank.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.ReplyDto;
import com.biz.grank.persistence.ReplyDao;

@Service
public class ReplyServiceImp implements ReplyService {

	@Inject
	SqlSession sqlSession;
	
	ReplyDao rDao;
	
	@Inject
	public void getMapper() {
		rDao = sqlSession.getMapper(ReplyDao.class);
	}

	@Override
	public List<ReplyDto> listAll(int bno) {
		// TODO Auto-generated method stub
		return rDao.listAll(bno);
	}
}
