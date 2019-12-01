package com.biz.grank.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.grank.domain.AwardsRankDto;
import com.biz.grank.domain.ComingSoonDto;
import com.biz.grank.domain.CriticDto;
import com.biz.grank.domain.GameRankDto;
import com.biz.grank.domain.UserDto;
import com.biz.grank.persistence.GameDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GameServiceImp implements GameService {

	@Autowired
	private GameDao gDao;

	
	@Override
	// 1. 출시예정작 리스트 출력
	public List<ComingSoonDto> cFindAll() {
		List<ComingSoonDto> clist = gDao.cFindAll();
		return gDao.cFindAll();
	}


	@Override
	// 2. 출시예정작 6건 출력
	public List<ComingSoonDto> cFindLimit() {
		List<ComingSoonDto> clist = gDao.cFindLimit();
		return gDao.cFindLimit();
	}

	// 3. 게임평가순위리스트 5건 출력
	@Override
	public List<GameRankDto> gFindLimit(String platform) {
		List<GameRankDto> gList = gDao.gFindLimit(platform);
		for(GameRankDto gDto : gList) {
			if(gDto.getU_score().equals("tbd")) {
				gDto.setTot_score(Double.valueOf(gDto.getM_score()));
			} else {
				double u_score = Double.valueOf(gDto.getU_score())*10;
				double m_score = Double.valueOf(gDto.getM_score());
				double tot_score = (m_score + u_score)/2;
				int uscore = (int) u_score;
				gDto.setU_score(String.valueOf(uscore));
				gDto.setTot_score(tot_score);
			}
		}
		return gList;
	}

	// 4. 게임평가순위리스트 size 구하는 메소드
	@Override
	public List<GameRankDto> gFindPlatform(String platform) {
		List<GameRankDto> gList = gDao.gFindPlatform(platform);
		return gList;
	}

	// 5. 게임평가순위리스트 몇 건만 출력
	@Override
	public List<GameRankDto> gMoreView(Map<String, Object> gMap) {
		List<GameRankDto> gList = gDao.gMoreView(gMap);
		
		// 유저점수. 전문가 점수 합산 후 평균값 구해서 Grank 점수 만드는 로직
		for(GameRankDto gDto : gList) {
			if(gDto.getU_score().equals("tbd")) {
				gDto.setTot_score(Double.valueOf(gDto.getM_score()));
			} else {
				double u_score = Double.valueOf(gDto.getU_score())*10;
				double m_score = Double.valueOf(gDto.getM_score());
				double tot_score = (m_score + u_score)/2;
				int uscore = (int) u_score;
				gDto.setU_score(String.valueOf(uscore));
				gDto.setTot_score(tot_score);
			}
			
		}
		return gList;
	}

	// 6. 출시예정작 몇 건만 출력
	@Override
	public List<ComingSoonDto> cMoreView(int count) {
		List<ComingSoonDto> cList = gDao.cMoreView(count);
		return cList;
	}

	// 7. 게임평가순위리스트 단건 출력
	@Override
	public GameRankDto gameView(String game_code) {
		return gDao.gameView(game_code);
	}

	// 8. Ajax 비평가리뷰 리스트 출력
	@Override
	public List<CriticDto> gFindCritic(Map<String, Object> criticMap) {
		List<CriticDto> criticList = gDao.gFindCritic(criticMap);
		return criticList;
	}

	// 9. Ajax 유저리뷰 리스트 출력
	@Override
	public List<UserDto> gFindUser(Map<String, Object> userMap) {
		List<UserDto> userList = gDao.gFindUser(userMap); 
		return userList;
	}

    // 10. Ajax 비평가 댓글 리스트 
	@Override
	public int cReviewSize(String game_code) {
		return gDao.cReviewSize(game_code);
	}

	// 11. Ajax 유저 댓글 리스트 
	@Override
	public int uReviewSize(String game_code) {
		return gDao.uReviewSize(game_code);
	}

	// 12. 수상 및 랭킹 리스트
	@Override
	public AwardsRankDto rFindAll(String game_code) {
		AwardsRankDto rDto = gDao.rFindAll(game_code);
		return rDto;
	}

	// 13. 게임 검색결과 리스트
	@Override
	public List<GameRankDto> gSearchList(String keyword) {
		// TODO Auto-generated method stub
		return gDao.gSearchList(keyword);
	}


	@Override
	public List<GameRankDto> mygameList(List<String> favoriteList) {
		// TODO Auto-generated method stub
		List<GameRankDto> mygameList = new ArrayList<GameRankDto>();
		for(String gamecode : favoriteList) {
			mygameList.add(gDao.mygame(gamecode));
		}
		return mygameList;
	}



}
