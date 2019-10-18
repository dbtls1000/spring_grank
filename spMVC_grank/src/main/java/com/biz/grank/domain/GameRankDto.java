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
	private int m_score;
	private	String game_name;
	private String platform;
	private float u_score;
	private String img_src;
	
	public GameRankDto(String game_code, int m_score, String game_name, String platform, float u_score,  String img_src) {
		this.game_code = game_code;
		this.m_score = m_score;
		this.game_name = game_name;
		this.platform = platform;
		this.u_score = u_score;
		this.img_src = img_src;
	}
	
}
