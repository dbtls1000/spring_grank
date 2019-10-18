package com.biz.grank.persistence;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.stereotype.Repository;

import com.biz.grank.domain.ComingSoonDto;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
public class GameDao {
	
	@Autowired
	private MongoOperations mongoOper;
	
	
	
	// 1. 커밍순 리스트 출력 
	public List<ComingSoonDto> findAll() {
		List<ComingSoonDto> cList = mongoOper.findAll(ComingSoonDto.class, "comingsoon");
		return cList;
	}
	
	// 2. n건만 가져오는 리스트
	public List<ComingSoonDto> findLimit() {
		// 1) 컬렉션에서 가져올 데이터 쿼리문 작성
		BasicQuery query = (BasicQuery) new BasicQuery("{}, platform:'platform', c_img:'c_img', c_name:'c_name', c_date:'c_date'").limit(6);
		// 2) 쿼리문 리스트에 저장
		List<ComingSoonDto> cList = mongoOper.find(query, ComingSoonDto.class, "comingsoon");		
		return cList;
	}
	
	
	
}
