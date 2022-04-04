package com.spring.codelog.board.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.spring.codelog.board.commons.ImgVO;
import com.spring.codelog.board.model.BoardVO;

public interface IBoardMapper {
	// 01. 게시글 작성  
	void write(BoardVO vo);

	void image(ImgVO vo);

	BoardVO test(int boardId);


	// 02. 게시글 상세보기
	BoardVO read(int boardId) ;
	// 03. 게시글 수정
	void update(BoardVO vo) ;
	// 03-1. 수정 글 불러오기
	BoardVO modify(int boardId);
	// 04. 게시글 삭제
	void delete(int boardId) ;
	// 05. 게시글 전체 목록
	List<BoardVO> listAll() ;
	// 06. 게시글 조회 증가
	void increaseHit(int boardId) ;

	
	// 07. 게시글 좋아요 증가(유저 기준 아님 상세보기 해당 게시글 기준임)
	void totalLikeUp(int boardId);
	
	// 08. 게시글 좋아요 감소(유저 기준 아님 상세보기 해당 게시글 기준임)
	void totalLikeDown(int boardId);
	
	public int currentBoardId();

	int lastbno();
	 	//우측 검색
		//검색 결과 리스트 보여주기
		List<BoardVO> search(String keyword);
		
	//탈퇴하는 사용자 모든 게시물 삭제하기	
	void deleteAll(String userId);
	
}
