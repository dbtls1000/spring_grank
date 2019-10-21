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
public class LikeDto {
	private int likeno;    
	private int bno;    
	private String userid;
	private int like_check;
}
