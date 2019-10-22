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
		// TODO 좋아요 정보 가져오기(어느 유저의, 어떤 게시글의 좋아요인지)
		return lDao.likeRead(map);
	}

	@Override
	public int countByLike(Map<String, Object> map) {
		// TODO 해당 유저와 해당 게시글의 해당하는 좋아요 정보가 있는지 검사
		return lDao.countByLike(map);
	}

	@Override
	public void createLike(Map<String, Object> map) {
		// TODO 좋아요 정보 새로 생성
		lDao.createLike(map);
	}
	@Override
	public void like_check(Map<String, Object> map) {
		// TODO 좋아요를 누를 경우 like_check +1
		lDao.like_check(map);
	}
	@Override
	public void like_check_cansel(Map<String, Object> map) {
		// TODO 좋아요를 다시 누를 경우 like_check 0
		lDao.like_check_cansel(map);
	}

}
