package com.biz.grank.domain;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
@Document(collection = "awardsrank")
public class AwardsRankDto {
	
	@Id
	private String id;
	private String game_code;
	private List<String> awardslist;
	
		AwardsRankDto(String game_code, List<String> awardslist){
			this.game_code = game_code;
			this.awardslist  = awardslist;
		}
}
