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
	private int bno;//	게시글 번호
	private String b_title;//	게시글 제목
	private String b_content;//	게시글 내용
	private String b_writer;//	게시글 작성자
	private String b_platform;//	게시글 종류
	private int b_viewcnt;//	게시글 조회수
	private int b_replycnt;//	게시글 댓글수
	private Date b_regdate;//	게시글 작성일자
	private int ref;//	해당게시글의 답변번호
	private int re_step;//	
	private int re_level;//	
	private int prev_bno; // 이전 게시글 번호
	private int next_bno; // 다음 게시글 번호
}
