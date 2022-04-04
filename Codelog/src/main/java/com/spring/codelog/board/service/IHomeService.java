package com.spring.codelog.board.service;

import java.util.List;

import com.spring.codelog.board.model.BoardVO;

public interface IHomeService {
	
	
	List<BoardVO> TPosters(String start, String end);
	
	List<BoardVO> TAPosters(int likes, String start, String end);


	List<BoardVO> RPosters();
	
	List<BoardVO> RAPosters(int i, int boardId);

	List<BoardVO> FPosters(int userNo);
	
	List<BoardVO> FAPosters(int boardId, int userNo);

	//BoardVO SelectOne(int i);
	
//	BoardVO SelectOneT(int i);

	
	int FPCount(String userId);
	
	int PCount();


}