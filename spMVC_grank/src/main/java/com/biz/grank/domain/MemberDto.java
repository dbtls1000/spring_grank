package com.biz.grank.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MemberDto {

	private String userid; // 유저 아이디
	private String passwd; // 유저 비밀번호
	private String name; //  닉네임
	private String phone; //  전화번호
	private String email; //  이메일
	private String zipcode; //  우편번호
	private String addr1; //  주소
	private String addr2; //  상세주소
	private String regdate; // 가입일
	private boolean check; // 자동 로그인 체크
	private String sessionkey; // 자동 로그인 체크 후 로그인 할때 저장될 아이디 값
	private long sessionlimit; // 자동 로그인 체크 후 로그인 할때 저장될 날짜 시간
	private long currentTimeMillis; // 자동 로그인 되어있을때 비교할 현재 날짜 시간 
}
