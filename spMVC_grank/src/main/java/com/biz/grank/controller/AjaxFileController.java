package com.biz.grank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.grank.domain.FileDto;
import com.biz.grank.service.AjaxFileService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("ajaxfile/*")
public class AjaxFileController {
	
	@Autowired
	AjaxFileService afService;
	
	// 이미지 파일을 드래그앤드롭한 경우 업로드폴더에 업로드 실행단
	@ResponseBody
	@PostMapping("fileup")
	public List<FileDto> file_up(MultipartHttpServletRequest files) {
		List<FileDto> fileDtoList = afService.upLoads(files);
		return fileDtoList;
	}
	
	// 이미지를 삭제하는 경우
	@ResponseBody
	@GetMapping("delete")
	public String delete(@RequestParam(defaultValue = "0")int fno,String file_name) {
		log.info(">>fno>>"+fno);
		boolean okDelete = afService.file_delete(fno,file_name);
		
		// okDelete가 true면 OK를 리턴
		if(okDelete) return "OK";
		// false일 경우 FAIL을 리턴
		else return "FAIL";
	}
}
