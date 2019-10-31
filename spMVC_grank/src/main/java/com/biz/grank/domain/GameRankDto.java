package com.biz.grank.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Document(collection = "metascore ")
public class GameRankDto {
	
	@Id
	private String id;
	private String game_code;
	private String m_score;
	private	String game_name;
	private String platform;
	private String u_score;
	private String img_src;
	private double tot_score;
	
	public GameRankDto(String game_code, String m_score, String game_name, String platform, String u_score,  String img_src, double tot_score) {
		this.game_code = game_code;
		this.m_score = m_score;
		this.game_name = game_name;
		this.platform = platform;
		this.u_score = u_score;
		this.img_src = img_src;
		this.tot_score = tot_score;
	}
	
}
