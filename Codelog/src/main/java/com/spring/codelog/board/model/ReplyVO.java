package com.spring.codelog.board.model;

import java.util.Date;

import org.springframework.stereotype.Service;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReplyVO {
	private int no;
	private int bno;	//	댓글이 속한 게시글 번호 (받아와야 하는 값)
	private int grp;	//	댓글 그룹 번호 (모댓글과 거기에 속한 대댓글은 같은 grp를 가짐)
	private int grps;	//	그룹 내 댓글 순서 (오래된글 ~ 최신글  오름차순)
	private int grpl;	//	그룹내 댓글 깊이(댓글인지 대댓글인지)
	private int userNo;
	private String userId;
	private String userImg;
	private String writer;
	private String content;
	private Date wdate;
	 
}
