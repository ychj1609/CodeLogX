package com.spring.codelog.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.codelog.board.model.BoardVO;

public interface ISearchMapper {
	
	//검색 결과 리스트 보여주기
	List<BoardVO> search(String keyword);
	List<BoardVO> searchId(String userId);

	//검색 결과 리스트 보여주기
	List<BoardVO> searchMypage(@Param("keyword") String keyword,@Param("userId") String userId);
	
	//태그 검색결과
	List<BoardVO> searchByTag(String keyword);
}
