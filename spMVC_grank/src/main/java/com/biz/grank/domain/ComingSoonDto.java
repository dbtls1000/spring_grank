package com.biz.grank.domain;

import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Document(collection = "comingsoon")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class ComingSoonDto {
	private String name;
	private String date;
	private String img;
	private String game;

}
