package com.biz.grank.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.FavoriteDto;
import com.biz.grank.persistence.FavoriteDao;

@Service
public class FavoriteServiceimp implements FavoriteService {
	
	@Autowired
	SqlSession sqlSession;
	
	FavoriteDao fDao;
	
	@Autowired
	public void getMapper() {
		fDao = sqlSession.getMapper(FavoriteDao.class);
	}
	
	@Override
	public int checkFavorite(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return fDao.checkFavorite(map);
	}

	@Override
	public void makeFavorite(Map<String, Object> map) {
		// TODO Auto-generated method stub
		fDao.makeFavorite(map);
	}

	@Override
	public FavoriteDto readOne(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return fDao.readOne(map);
	}

	@Override
	public void favoriteCheck(Map<String, Object> map) {
		// TODO Auto-generated method stub
		fDao.favoriteCheck(map);
	}

	@Override
	public void favoriteCheckCancel(Map<String, Object> map) {
		// TODO Auto-generated method stub
		fDao.favoriteCheckCancel(map);
	}

	@Override
	public List<FavoriteDto> gamecodeList(String userid) {
		// TODO Auto-generated method stub
		return fDao.gamecodeList(userid);
	}

}
