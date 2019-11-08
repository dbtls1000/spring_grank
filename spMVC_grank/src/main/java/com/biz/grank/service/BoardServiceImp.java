package com.biz.grank.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.domain.LikeDto;
import com.biz.grank.persistence.BoardDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImp implements BoardService {
	@Inject
	SqlSession sqlSession;
	
	BoardDao bDao;
	
	@Autowired
	AjaxFileService afService;
	
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

	@Transactional
	@Override
	public void save(BoardDto bDto) {
		// TODO 게시글 작성/수정을 bno값을 통해 진행
		// bno가 0이면 작성
		if(bDto.getBno() == 0) {
			bDao.insert(bDto);
			log.info(">>bno>>"+bDto.getBno());
			afService.insert(bDto);
		} else { // 0이 아니면 수정
			bDao.update(bDto);
			afService.insert(bDto);
		}
	}
	
	
	@Transactional
	@Override
	public void answer(BoardDto bDto) {
		// TODO 게시글 답변
		log.info(">>>>>>>>>>"+bDto);
		// 게시글 답변 등록전 등록하려는 답변보다 높은 re_step을 +1 해주는 작업
		bDao.updateRestep(bDto);
		
		if(bDto.getRe_level() == 0) {
			bDto.setB_title("⤷"+bDto.getB_title());
		} else {
			bDto.setB_title("&nbsp;"+bDto.getB_title());
		}
		
		bDto.setRe_step(bDto.getRe_step()+1);
		bDto.setRe_level(bDto.getRe_level()+1);
		// 게시글 답변 등록
		bDao.answer(bDto);
	}

	@Override
	public void delete(int bno) {
		// TODO 게시글 삭제
		bDao.delete(bno);
	}

	@Override
	public void increaseViewCnt(int bno, HttpSession httpSession) {
		// TODO Auto-generated method stub
		long update_time = 0;
		String name = (String)httpSession.getAttribute("name");
		BoardDto bDto = bDao.readOne(bno);
		
		// 로그인 되있으면 조회수+1 그외 변동x
		if(httpSession.getAttribute("name")!=null) {
			// 로그인 된 회원가 작성자가 같은 경우 조회수 변동x
			if(bDto.getB_writer().equals(name)) {
				
			} else { // 로그인 된 회원가 작성자가 다른 경우 조회수 + 1
				// "update_time_"+bno가 null이 아닌경우(조회수를 이미 1회 올린경우)
				if(httpSession.getAttribute("update_time_"+bno) != null) {
					// update_time에 세션으로부터 "update_time_"+bno값을 받아와 담는다
					update_time = (long)httpSession.getAttribute("update_time_"+bno);
				};
				// 현재시각
				long current_time = System.currentTimeMillis();
				// 현재시각과 조회수를 올린시간의 차이가 24시간이 넘어가면
				// 조회수 +1 그리고 "update_time_"+bno에 현재시각을 담기
				if(current_time - update_time > 24*60*60*1000) {
					bDao.increaseViewCnt(bno);
					//조회수를 증가한 시간 session에 저장
					httpSession.setAttribute("update_time_"+bno, current_time);
				}
				// 해당 게시글의 조회수 +1
			}
		}
	}

	@Override
	public void like_cnt_up(int bno) {
		// TODO 좋아요를 누를 경우 like_cnt + 1
		bDao.like_cnt_up(bno);
	}

	@Override
	public void like_cnt_down(int bno) {
		// TODO 좋아요를 취소할 경우 like_cnt - 1
		bDao.like_cnt_down(bno);
	}

	@Override
	public List<BoardDto> readByWriter(Map<String, Object> map) {
		// TODO 작성자로 여러건 찾아오기
		return bDao.readByWriter(map);
	}

	@Override
	public int countByWriter(String name) {
		// TODO 작성자로 검색한 게시글 수
		return bDao.countByWriter(name);
	}

	@Override
	public List<BoardDto> popularList() {
		// TODO 조회수 높은 순서대로 5건만 기져옴
		return bDao.popularList();
	}

	@Override
	public void updateWriter(Map<String, String> map) {
		// TODO 회원정보에서 닉네임 변경시 게시글정보의 작성자를 바꾸어주는 작업
		bDao.updateWriter(map);
	}

}
