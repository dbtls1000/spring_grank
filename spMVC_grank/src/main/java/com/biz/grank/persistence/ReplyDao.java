package com.biz.grank.persistence;

import java.util.List;
import java.util.Map;

import com.biz.grank.domain.ReplyDto;

public interface ReplyDao {

	public List<ReplyDto> listAll(int bno);

	public void insert_reply(ReplyDto rDto);

	public void updateReplyCnt(Map<String, Object> map);

	public void delete_reply(ReplyDto rDto);

	public void update_reply(ReplyDto rDto);

}
