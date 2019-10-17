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
@Getter
@Setter
@ToString
@Document(collection = "comingsoon")  // collection Name
public class ComingSoonDto {
	
	@Id
	private String id;
	private String c_name;
	private String c_date;
	private String c_img;
	private String platform;
	
	public ComingSoonDto(String c_name, String c_date, String c_img, String platform){
		super();
		this.platform = platform;
		this.c_name = c_name;
		this.c_img = c_img;
		this.c_date = c_date;
	}
}
