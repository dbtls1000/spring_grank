package com.biz.grank.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.domain.FileDto;
import com.biz.grank.domain.LikeDto;
import com.biz.grank.service.AjaxFileService;
import com.biz.grank.service.BoardService;
import com.biz.grank.service.LikeService;
import com.biz.grank.service.Pagination;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("board/*")
public class BoardController {
	
	@Autowired
	BoardService bService;
	@Autowired
	LikeService lService;
	@Autowired
	AjaxFileService afService;
	
	// 게시글 리스트 화면단
	@GetMapping("list")
	public String list(@RequestParam(defaultValue = "1")int curPage,
						@RequestParam(defaultValue = "title_content")String search_option,
						@RequestParam(defaultValue = "") String keyword,
						@RequestParam(defaultValue = "new") String sort_option,
						Model model) {
		log.info(">>>>"+search_option);
		log.info(">>>>"+keyword);
		// 검색,페이지네이션,정렬을 하기위한 값들을 담을 map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search_option", search_option);
		// 조건문에서 keyword 앞뒤로 %를 붙여 검색하기 위해 설정
		map.put("keyword", "%"+keyword+"%");
		map.put("sort_option",sort_option);
		// 페이지네이션을 위한 게시글 수
		int count = bService.countList(map);
		Pagination page = new Pagination(count, curPage);
		// rownum 시작값
		int start = page.getPageBegin();
		// rownum 끝값
		int end = page.getPageEnd();
		
		map.put("start", start);
		map.put("end", end);
		
		// view단에서 사용할 변수들 model에 담기
		model.addAttribute("sort",sort_option);
		model.addAttribute("blist",bService.listAll(map));
		model.addAttribute("search_option",search_option);
		model.addAttribute("keyword",keyword);
		model.addAttribute("page",page);
		model.addAttribute("count",count);
		return "board/list";
	}
	
	// 상세 게시글 화면단
	@GetMapping("view")
	public String view(int bno, Model model,HttpSession httpSession) {
		log.info(">>이전,다음글 번호 확인>>" + bService.readOne(bno));
		// 세션으로부터 userid값 받아오기
		String userid = (String)httpSession.getAttribute("userid");
		// userid가 null값이 아니면(로그인 되있다면)
		if(userid != null) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userid", userid);
			map.put("bno", bno);
			// countByLike함수를 통해 해당유저의 해당게시글 좋아요 정보(likeno)이 있는지 없는지 확인
			// 0이면 없으므로 좋아요 정보를 새로 생성한다.
			if(lService.countByLike(map) == 0) {
				lService.createLike(map);
			}
			// 해당게시글의 좋아요를 체크했는지 안했는지 view단으로 보내주기위한 model
			model.addAttribute("lDto",lService.likeRead(map));
		}
		// 조회수 + 1
		bService.increaseViewCnt(bno, httpSession);
		log.info("파일리스트"+afService.readByBno(bno));
		model.addAttribute("fList", afService.readByBno(bno));
		model.addAttribute("bDto", bService.readOne(bno));
		log.info(">bDto>" + bService.readOne(bno));
		return "board/view";
	}
	
	// 게시글 작성 화면단
	@GetMapping("write")
	public String write(@RequestParam(defaultValue = "0")int bno, Model model) {
		// bno가 0이 아니면 write.jsp를 수정으로 사용 model에 단건 정보 담기
		if(bno != 0) {
			model.addAttribute("fList", afService.readByBno(bno));
			model.addAttribute("bDto",bService.readOne(bno));
		}
		return "board/write";
	}
	
	// 게시글 작성 실행
	@PostMapping("write")
	public String write(BoardDto bDto,HttpSession httpSession) {
		// 로그인 된 세션값으로부터 작성자이름을 꺼내와 name에 담기
		String name = (String)httpSession.getAttribute("name");
		// name을 bDto의 b_writer에 담기
		bDto.setB_writer(name);
		// bno값에 따른 작성/수정
		log.info(">>b_writer>>" + bDto);
		bService.save(bDto);
		return "redirect:/board/view?bno="+bDto.getBno();
	}
	
	// 게시글 답변 화면단
	@GetMapping("answer")
	public String answer(@RequestParam(defaultValue = "0")int bno,Model model) {
		if(bno !=0) {
			model.addAttribute("bDto", bService.readOne(bno));
			model.addAttribute("fList",afService.readByBno(bno));
		}
		// 답변등록일경우 flag에 answer값 담기
		model.addAttribute("flag","answer");
		return "board/write";
	}
	
	// 게시글 답변 실행
	@PostMapping("answer")
	public String answer(BoardDto bDto,HttpSession httpSession) {
		// 로그인 된 세션값으로부터 작성자이름을 꺼내와 name에 담기
		String name = (String)httpSession.getAttribute("name");
		// name을 bDto의 b_writer에 담기
		bDto.setB_writer(name);
		// 답변을 달고자하는 게시글의 정보를 가져와 ref,re_step,re_level을 set한다
		BoardDto pDto = bService.readOne(bDto.getBno());
		bDto.setRef(pDto.getRef());
		bDto.setRe_step(pDto.getRe_step());
		bDto.setRe_level(pDto.getRe_level());
		
		bService.answer(bDto);
		return "redirect:/board/view?bno="+bDto.getBno();
	}
	
	// 게시글 삭제 실행
	@GetMapping("delete")
	public String delete(int bno) {
		bService.delete(bno);
		return "redirect:/board/list";
	}
	
	// 게시글 좋아요 기능(Ajax)
	@ResponseBody
	@GetMapping("like")
	public String like(int bno,HttpSession httpSession) {
		// 세션으로부터 userid값 받아오기
		String userid = (String)httpSession.getAttribute("userid");
		JSONObject obj = (JSONObject) new JSONObject();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("bno", bno);
		LikeDto lDto = lService.likeRead(map);
		// 좋아요 체크 값
		int like_check = lDto.getLike_check();
		log.info("좋아요체크"+like_check);
		// countByLike함수를 통해 해당유저의 해당게시글 좋아요 정보(likeno)이 있는지 없는지 확인
		// 0이면 없으므로 좋아요 정보를 새로 생성한다.
		if(lService.countByLike(map) == 0) {
			lService.createLike(map);
		}
		// like_check가 0이면 like_check을 1로 변경 & like_cnt를 +1
		if(like_check == 0) {
			lService.like_check(map);
			bService.like_cnt_up(bno);
		} else { // like_check가 0이 아니면(1일경우) like_check을 0으로 변경 & like_cnt를 -1
			lService.like_check_cansel(map);
			bService.like_cnt_down(bno);
		}
		BoardDto bDto = bService.readOne(bno);
		int like_cnt = bDto.getLike_cnt();
		// obj에 like_check을 put
		obj.put("like_check", like_check);
		obj.put("like_cnt", like_cnt);
		return obj.toJSONString();
	}
	
//	// 다운로드
//	@GetMapping("download")
//	public String down(int fno,HttpServletRequest request, HttpSession httpSession) {
//		FileDto fileDto = afService.readOne(fno);
//		
//		String path = "c:/bizwork/upload";
//		String originName = fileDto.getOrigin_name();
//		String fileName = fileDto.getFile_name();
//		
//		request.setAttribute("path", path);
//		request.setAttribute("originName", originName);
//		request.setAttribute("fileName", fileName);
//		return "board/download";
//	}
}
