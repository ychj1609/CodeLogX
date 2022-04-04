package com.spring.codelog.user.model;

import java.util.List;

import com.spring.codelog.board.model.BoardVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class UserVO {
	private String userId;
	private String userPw;
	private String nickname;
	private String email1;
	private String email2;
	private String userInfo;
	private String userImg;
	private int userNo;
	
	private List<BoardVO> boardList;
}