package com.biz.grank.service;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.LikeDto;
import com.biz.grank.persistence.LikeDao;

@Service
public class LikeServiceImp implements LikeService {
	
	@Inject
	SqlSession sqlSession;
	
	LikeDao lDao;
	
	@Inject
	public void getMapper() {
		lDao = sqlSession.getMapper(LikeDao.class);
	}
	@Override
	public LikeDto likeRead(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return lDao.likeRead(map);
	}

	@Override
	public int countByLike(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return lDao.countByLike(map);
	}

	@Override
	public void createLike(Map<String, Object> map) {
		// TODO Auto-generated method stub
		lDao.createLike(map);
	}
	@Override
	public void like_check(Map<String, Object> map) {
		// TODO Auto-generated method stub
		lDao.like_check(map);
	}
	@Override
	public void like_check_cansel(Map<String, Object> map) {
		// TODO Auto-generated method stub
		lDao.like_check_cansel(map);
	}

}
