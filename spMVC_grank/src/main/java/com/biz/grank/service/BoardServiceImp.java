package com.biz.grank.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.persistence.BoardDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImp implements BoardService {
	@Inject
	SqlSession sqlSession;
	
	BoardDao bDao;
	
	@Inject
	public void getMapper() {
		bDao = sqlSession.getMapper(BoardDao.class);
	}

	@Override
	public int countList(Map<String, Object> map) {
		// TODO 게시글 리스트 개수
		return bDao.countList(map);
	}

	@Override
	public List<BoardDto> listAll(Map<String, Object> map) {
		// TODO 게시글 리스트 가져옴
		return bDao.listAll(map);
	}

	@Override
	public BoardDto readOne(long bno) {
		// 게시글 단건의 정보 가져옴
		return bDao.readOne(bno);
	}

	@Override
	public void save(BoardDto bDto) {
		// TODO 게시글 작성/수정을 bno값을 통해 진행
		// bno가 0이면 작성
		if(bDto.getBno() == 0) {
			bDao.insert(bDto);
		} else { // 0이 아니면 수정
			bDao.update(bDto);
		}
	}
	
	@Transactional
	@Override
	public void answer(BoardDto bDto) {
		// TODO 게시글 답변
		// 게시글 답변 등록전 등록하려는 답변보다 높은 re_step을 +1 해주는 작업
		log.info(">>>>>>>>>>"+bDto);
		bDao.updateRestep(bDto);
		bDto.setB_title("┖"+bDto.getB_title());
		bDto.setRe_step(bDto.getRe_step()+1);
		bDto.setRe_level(bDto.getRe_level()+1);
		bDao.answer(bDto);
	}

	@Override
	public void delete(int bno) {
		// TODO 게시글 삭제
		bDao.delete(bno);
	}
}
