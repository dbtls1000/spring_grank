package com.biz.grank.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.domain.FileDto;

public interface AjaxFileService {

	public List<FileDto> upLoads(MultipartHttpServletRequest files);

	public boolean file_delete(int fno);
	
	public void insert(BoardDto bDto);
	
	public void files_delete(int bno);

	public List<FileDto> readByBno(int bno);
}
