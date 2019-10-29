package com.biz.grank.persistence;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.stereotype.Repository;

import com.biz.grank.domain.AwardsRankDto;
import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.CriticDto;
import com.biz.grank.domain.GameRankDto;
import com.biz.grank.domain.UserDto;

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
		BasicQuery query = (BasicQuery) new BasicQuery("{}, platform:'platform', c_img:'c_img', c_name:'c_name', c_date:'c_date'").limit(5);
		// 2) 쿼리문 리스트에 저장
		List<ComingSoonDto> cList = mongoOper.find(query, ComingSoonDto.class, "comingsoon");		
		return cList;
	}
	
	// 3. 게임평가순위리스트 5건 출력
	public List<GameRankDto> gFindLimit(String platform) {
		// 1) 컬렉션에서 가져올 데이터 쿼리문 작성
		// { platform':'"+platform+ } < RDBMS의 조건절 플랫폼 값을 받아 자바스크립트에서 클릭 시 종류별로 바뀌게 하기위해서 받음
		// platform:'platform', game_code:'game_code', < RDBMS select(game_code,  platform ....)와 같음 
		BasicQuery query = (BasicQuery) new BasicQuery("{'platform':'"+platform+"'}, platform:'platform', game_code:'game_code', m_score:'m_score', game_name:'game_name', u_score:'u_score', img_src:'img_src' " ).limit(5);
		// 2) 게임평가순위리스트 m_score 순으로 내림차순 정렬 
		query.with(new Sort(Sort.Direction.DESC, "m_score"));
		// 3) 쿼리문 리스트에 저장
		List<GameRankDto> gList = mongoOper.find(query, GameRankDto.class, "metascore");		
		return gList;
		
	}
	
	// 4. 게임평가순위리스트 size 구하는 메소드
	public List<GameRankDto> gFindPlatform(String platform){
		BasicQuery query = (BasicQuery) new BasicQuery("{},");
		if(platform.equals("all")) {
			query = (BasicQuery) new BasicQuery("{}, platform:'platform', game_code:'game_code', m_score:'m_score', game_name:'game_name', u_score:'u_score', img_src:'img_src' " ); 
		} else {
			query = (BasicQuery) new BasicQuery("{'platform':'"+platform+"'}, platform:'platform', game_code:'game_code', m_score:'m_score', game_name:'game_name', u_score:'u_score', img_src:'img_src' " );
		}
		
		List<GameRankDto> gList = mongoOper.find(query, GameRankDto.class, "metascore");	
		return gList;
	}
	
	// 5. 게임평가순위리스트 count건만 출력 
	public List<GameRankDto> gMoreView(Map<String, Object> gMap) {
		BasicQuery query = (BasicQuery) new BasicQuery("{},");
		if(gMap.get("platform").equals("all")) {
			query = (BasicQuery) new BasicQuery("{}, platform:'platform', game_code:'game_code', m_score:'m_score', game_name:'game_name', u_score:'u_score', img_src:'img_src' ").limit((int) gMap.get("count"));
		} else {
			query = (BasicQuery) new BasicQuery("{'platform':'"+gMap.get("platform")+"'}, platform:'platform', game_code:'game_code', m_score:'m_score', game_name:'game_name', u_score:'u_score', img_src:'img_src' ").limit((int) gMap.get("count"));
		}
		List<GameRankDto> gList = mongoOper.find(query,	GameRankDto.class, "metascore");
		
		return gList;
	}
	
	// 6. 커밍순리스트 count 건만 출력
	public List<ComingSoonDto> cMoreView(int count) {
		BasicQuery query = (BasicQuery) new BasicQuery("{}, platform:'platform', c_img:'c_img', c_name:'c_name', c_date:'c_date'").limit(count);
		List<ComingSoonDto> cList = mongoOper.find(query, ComingSoonDto.class, "comingsoon");
		return cList;
	}

	// 7. 게임 단건 출력
	public GameRankDto gameView(String game_code) {
		BasicQuery query = (BasicQuery) new BasicQuery("{'game_code' : '"+game_code+"'}, game_code:'game_code', platform:'platform', c_img:'c_img', c_name:'c_name', c_date:'c_date");
		return mongoOper.findOne(query, GameRankDto.class, "metascore");
	}
	
	// 8. 비평가 리스트 출력
	public List<CriticDto> gFindCritic(Map<String, Object> criticMap) {
		BasicQuery query = (BasicQuery) new BasicQuery("{'game_code' : '"+criticMap.get("game_code")+"'}, game_code:'game_code', c_score:'c_score', c_critic:'c_critic', c_review:'c_review' ").limit((int) criticMap.get("count"));
		List<CriticDto> criticList = mongoOper.find(query, CriticDto.class, "critic");
		return criticList;
	}
    
	// 9. 유저 리스트 출력
	public List<UserDto> gFindUser(Map<String, Object> userMap) {
		BasicQuery query = (BasicQuery) new BasicQuery("{'game_code' : '"+userMap.get("game_code")+"'}, game_code:'game_code', u_score:'u_score', u_name:'u_name', u_review:'u_review' ").limit((int) userMap.get("count"));
		List<UserDto> userList = mongoOper.find(query, UserDto.class, "userreview");
		return userList;
	}

	public int cReviewSize(String game_code) {
		BasicQuery query = (BasicQuery) new BasicQuery("{'game_code' : '"+game_code+"'}, game_code:'game_code', c_score:'c_score', c_critic:'c_critic', c_review:'c_review' ");
		List<CriticDto> criticList = mongoOper.find(query,CriticDto.class, "critic");
		return criticList.size();
	}

	public int uReviewSize(String game_code) {
		BasicQuery query = (BasicQuery) new BasicQuery("{'game_code' : '"+game_code+"'}, game_code:'game_code', u_score:'u_score', u_name:'u_name', u_review:'u_review' ");
		List<UserDto> userList = mongoOper.find(query, UserDto.class, "userreview");
		return userList.size();
	}

	public AwardsRankDto rFindAll(String game_code) {
		BasicQuery query = (BasicQuery) new BasicQuery("{'game_code' : '"+game_code+"'}, game_code:'game_code', awardslist:'awardslist' ");
		AwardsRankDto rDto = mongoOper.findOne(query, AwardsRankDto.class, "awardsrank");
		return rDto;
	}

	public List<GameRankDto> gSearchList(String keyword) {
		// TODO Auto-generated method stub
		BasicQuery query = (BasicQuery) new BasicQuery("{'game_code' : /"+keyword+"/i}, game_code:'game_code', platform:'platform', c_img:'c_img', c_name:'c_name', c_date:'c_date");
		List<GameRankDto> gList = mongoOper.find(query, GameRankDto.class, "metascore");
		return gList;
	}	
	
	
	
}
