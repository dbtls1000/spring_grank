package com.biz.grank.persistence;

import java.util.Map;

import com.biz.grank.domain.FavoriteDto;

public interface FavoriteDao {

	public int checkFavorite(Map<String, Object> map);

	public void makeFavorite(Map<String, Object> map);

	public FavoriteDto readOne(Map<String, Object> map);

	public void favoriteCheck(Map<String, Object> map);

	public void favoriteCheckCancel(Map<String, Object> map);

}
