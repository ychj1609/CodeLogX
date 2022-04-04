
package com.spring.codelog.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.codelog.board.model.BoardVO;

public interface IHomeMapper {

	List<BoardVO> TPosters(@Param("start") String start,
			@Param("end") String end);
	List<BoardVO> TAPosters(@Param("likes") int likes, @Param("start") String start,
			@Param("end") String end);

	List<BoardVO> RPosters();
	
	List<BoardVO> RAPosters(@Param("i") int keyword,
			@Param("boardId") int boardId);

	

	List<BoardVO> FPosters(int userNo);
	
	List<BoardVO> FAPosters(@Param("boardId") int boardId,
			@Param("userNo") int userNo);

	
	//BoardVO SelectOne(int i);
	
//	BoardVO SelectOneT(int i);

	
	int FPCount(String userId);
	
	int PCount();

}
