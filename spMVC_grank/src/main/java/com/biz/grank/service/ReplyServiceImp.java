package com.biz.grank.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.biz.grank.domain.ReplyDto;
import com.biz.grank.persistence.ReplyDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReplyServiceImp implements ReplyService {

	@Inject
	SqlSession sqlSession;
	
	ReplyDao rDao;
	
	@Inject
	public void getMapper() {
		rDao = sqlSession.getMapper(ReplyDao.class);
	}

	@Override
	public List<ReplyDto> listAll(int bno) {
		// TODO 댓글정보 모두 가져오기
		return rDao.listAll(bno);
	}
	
	@Transactional
	@Override
	public void save(ReplyDto rDto) {
		// TODO 댓글 작성
		log.info(">>rno>>" + rDto.getRno());
		if(rDto.getRno() == 0) {
			rDao.insert_reply(rDto);
			int bno = rDto.getBno();
			int flag = 1;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bno", bno);
			map.put("flag", flag);
			rDao.updateReplyCnt(map);
		} else {
			rDao.update_reply(rDto);
		}
		
		
	}
	
	@Transactional
	@Override
	public void delete(ReplyDto rDto) {
		// TODO 댓글 삭제
		rDao.delete_reply(rDto);
		int bno = rDto.getBno();
		int flag = -1;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("flag", flag);
		rDao.updateReplyCnt(map);
		
	}
}
