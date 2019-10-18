package com.biz.grank.service;

import java.util.List;

import com.biz.grank.domain.ReplyDto;

public interface ReplyService {

	public List<ReplyDto> listAll(int bno);

	public void save(ReplyDto rDto);

	public void delete(ReplyDto rDto);

}
