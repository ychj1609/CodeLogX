package com.spring.codelog.board.commons;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TagVO {
	private int tagNo;
	private String userId;
	private int boardId;
	private String tagName;
}
