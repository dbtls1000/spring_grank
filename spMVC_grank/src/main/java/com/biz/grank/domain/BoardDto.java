package com.biz.grank.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardDto {
	private int bno;//	number
	private String b_title;//	varchar2(200 byte)
	private String b_content;//	varchar2(4000 byte)
	private String b_writer;//	varchar2(30 byte)
	private String b_platform;//	varchar2(30 byte)
	private int b_viewcnt;//	number
	private int b_replycnt;//	number
	private Date b_regdate;//	date
	private int ref;//	number
	private int re_step;//	number
	private int re_level;//	number
}
