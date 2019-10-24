package com.biz.grank.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

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
@Document(collection = "critic")
public class CriticDto {
	
	@Id
	private String id;
	private String game_code;
	private int c_score;
	private String c_critic;
	private String c_review;
	
	public CriticDto(String game_code, int c_score, String c_critic, String c_review) {
		this.c_critic = c_critic;
		this.game_code = game_code;
		this.c_review = c_review;
		this.c_score = c_score;
	}
}
