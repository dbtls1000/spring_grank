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
@Document(collection = "userreview")
public class UserDto {
	
	@Id
	private String id;
	private String game_code;
	private int u_score;
	private String u_name;
	private String u_review;
	
	public UserDto(String game_code, int u_score, String u_name, String u_review) {
		this.game_code = game_code;
		this.u_name = u_name;
		this.u_score = u_score;
		this.u_review = u_review;
	}
}
