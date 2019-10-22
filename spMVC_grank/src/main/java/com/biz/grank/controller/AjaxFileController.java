package com.biz.grank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.grank.domain.FileDto;
import com.biz.grank.service.AjaxFileService;

@Controller
@RequestMapping("ajaxfile/*")
public class AjaxFileController {
	
	@Autowired
	AjaxFileService afService;
	
	@ResponseBody
	@PostMapping("fileup")
	public List<FileDto> files_up(MultipartHttpServletRequest files) {
		List<FileDto> fileDtoList = afService.upLoads(files);
		return fileDtoList;
	}
	
	@ResponseBody
	@GetMapping("delete")
	public String file_delete(int fno) {
		
		boolean okDelete = afService.file_delete(fno);
		
		if(okDelete) return "OK";
		else return "FAIL";
	}
}
