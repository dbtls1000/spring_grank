package com.biz.grank.persistence;

import java.util.Map;

import com.biz.grank.domain.MemberDto;

public interface MemberDao {

	void join(MemberDto mDto);

	boolean login(MemberDto mDto);

	MemberDto loginCheck(MemberDto mDto);

	MemberDto viewMember(String userid);

	void update(MemberDto mDto);

	int passCheck(Map<String, Object> map);

	void delete(String userid);

	void psupdate(MemberDto mDto);

	int idCheck(String userid);

	String ajaxEmailCheck(String email);

	String ajaxPswordCheck(Map<String, Object> map);

	int ajaxNameCheck(String name);


}
