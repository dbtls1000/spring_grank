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

	private String userid; // VARCHAR2(60),
	private String passwd; //  VARCHAR2(60) NOT NULL,
	private String name; //  VARCHAR2(30) NOT NULL,
	private String phone; //  VARCHAR2(30) NOT NULL,
	private String email; //  VARCHAR2(50) NOT NULL,
	private String zipcode; //  VARCHAR2(20) NOT NULL,
	private String addr1; //  VARCHAR2(200) NOT NULL,
	private String addr2; //  VARCHAR2(200) NOT NULL,
	private String regdate; //  DATE DEFAULT SYSDATE
}
