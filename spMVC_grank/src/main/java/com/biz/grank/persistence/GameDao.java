package com.biz.grank.persistence;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.stereotype.Repository;

import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.GameRankDto;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
public class GameDao {
	
	@Autowired
	private MongoOperations mongoOper;
	
	
	
	// 1. 출시예정작 리스트 출력 
	public List<ComingSoonDto> cFindAll() {
		List<ComingSoonDto> cList = mongoOper.findAll(ComingSoonDto.class, "comingsoon");
		return cList;
	}
	
	// 2. 출시예정작 n건만 가져오는 리스트
	public List<ComingSoonDto> cFindLimit() {
		// 1) 컬렉션에서 가져올 데이터 쿼리문 작성
		BasicQuery query = (BasicQuery) new BasicQuery("{}, platform:'platform', c_img:'c_img', c_name:'c_name', c_date:'c_date'").limit(6);
		// 2) 쿼리문 리스트에 저장
		List<ComingSoonDto> cList = mongoOper.find(query, ComingSoonDto.class, "comingsoon");		
		return cList;
	}
	
	// 3. 게임평가순위리스트 5건 출력
	public List<GameRankDto> gFindLimit(String platform) {
		// 1) 컬렉션에서 가져올 데이터 쿼리문 작성
		BasicQuery query = (BasicQuery) new BasicQuery("{'platform':'"+platform+"'}, platform:'platform', game_code:'game_code', m_score:'m_score', game_name:'game_name', u_score:'u_score', img_src:'img_src' " ).limit(5);
		// 2) 게임평가순위리스트 m_score 순으로 내림차순 정렬 
		query.with(new Sort(Sort.Direction.DESC, "m_score"));
		// 3) 쿼리문 리스트에 저장
		List<GameRankDto> gList = mongoOper.find(query, GameRankDto.class, "metascore");		
		return gList;
		
	}
	
	// 4. 게임평가순위리스트 모든 건 수 출력
	public List<GameRankDto> gFindAll(){
		
		// 1) 컬렉션에서 가져올 데이터 쿼리문 작성
		BasicQuery query = (BasicQuery) new BasicQuery("{}, platform:'platform', game_code:'game_code', m_score:'m_score', game_name:'game_name', u_score:'u_score', img_src:'img_src' ").limit(10);
		// 2) 게임평가순위리스트 m_score 순으로 내림차순 정렬 
		query.with(new Sort(Sort.Direction.DESC, "m_score"));
		// 3) 쿼리문 리스트에 저장

		List<GameRankDto> gList = mongoOper.find(query, GameRankDto.class, "metascore");		

		return gList;
				
		}
	
	
	
}
