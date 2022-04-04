package com.spring.codelog.board.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardVO {
	private int boardId;        // 게시글 번호
	private String userId;
	private String title;
	private String writer;
	private String tags;
	private String content;
	private String imgPath;
	private int likes;
	private Date regDate;
	private String preview;
	private String thumbnail;
	private String  viewAll;
	private int hit;        // 게시글 조회수
	private int recnt;            // **게시글 댓글의 수 추가
	private int userNo;
	
	
	// toString()
    @Override
    public String toString() {
        return "BoardVO [boardId=" + boardId + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regDate="
                + regDate + ", hit=" + hit + ", userId=" + userId + "]";
    }
	
}

