package com.biz.grank.persistence;

import java.util.List;

import com.biz.grank.domain.ReplyDto;

public interface ReplyDao {

	public List<ReplyDto> listAll(int bno);

}
