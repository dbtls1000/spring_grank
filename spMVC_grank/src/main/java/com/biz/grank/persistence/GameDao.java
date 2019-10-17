package com.biz.grank.persistence;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
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
		log.info("");
		Criteria criteria = new Criteria(); 
		Query query = new Query(criteria);
		List<ComingSoonDto> cList = mongoOper.find(query, ComingSoonDto.class,"comingsoon");
		
		for (ComingSoonDto comingSoonDto : cList) {
			log.info("Platform: ", comingSoonDto.getGame());
			log.info("c_name: ", comingSoonDto.getName());
			log.info("date: ", comingSoonDto.getDate());
			log.info("c_img: ", comingSoonDto.getImg());
		}
		
		return null;
	}
}
