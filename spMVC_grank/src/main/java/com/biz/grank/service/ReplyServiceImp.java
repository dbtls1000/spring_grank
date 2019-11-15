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
		// rno가 0이면 댓글 등록
		if(rDto.getRno() == 0) {
			rDao.insert_reply(rDto);
			int bno = rDto.getBno();
			// 댓글 등록이라고 알려주는 flag값
			int flag = 1;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bno", bno);
			map.put("flag", flag);
			// 댓글등록/삭제에따른 댓글수 업데이트
			rDao.updateReplyCnt(map);
		} else { // rno가 0이아니면 댓글 수정
			rDao.update_reply(rDto);
		}
		
		
	}
	
	@Transactional
	@Override
	public void delete(ReplyDto rDto) {
		// TODO 댓글 삭제
		rDao.delete_reply(rDto);
		int bno = rDto.getBno();
		// 댓글 삭제라고 알려주는 flag값
		int flag = -1;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("flag", flag);
		// 댓글등록/삭제에따른 댓글수 업데이트
		rDao.updateReplyCnt(map);
		
	}

	@Override
	public int countReply(int bno) {
		// TODO 해당 게시글의 댓글 수를 가져옴
		return rDao.countReply(bno);
	}
}
