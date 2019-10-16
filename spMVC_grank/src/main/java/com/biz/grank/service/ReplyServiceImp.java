package com.biz.grank.service;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

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
}
