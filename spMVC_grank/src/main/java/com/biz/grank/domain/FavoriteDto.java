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
public class FavoriteDto {
	public int fno;
	public String gamecode;
	public String userid;
	public int favorite_check;
}
