package com.biz.grank.domain;

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
public class ReplyDto {
	private int rno;
	private String r_content;
	private String r_writer;
	private String r_regdate;
	private int bno;
}
