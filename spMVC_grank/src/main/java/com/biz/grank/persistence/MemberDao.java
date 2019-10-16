package com.biz.grank.persistence;

import com.biz.grank.domain.MemberDto;

public interface MemberDao {

	void join(MemberDto mDto);

	boolean login(MemberDto mDto);

	MemberDto loginCheck(MemberDto mDto);

	MemberDto viewMember(String userid);


}
