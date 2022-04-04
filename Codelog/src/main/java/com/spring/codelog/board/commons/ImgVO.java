package com.spring.codelog.board.commons;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ImgVO {
	private int imgId;
	private int boardId;
	private String imgPath;
}
