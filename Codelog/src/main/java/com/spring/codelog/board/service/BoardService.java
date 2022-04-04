
package com.spring.codelog.board.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.codelog.board.commons.ImgVO;
import com.spring.codelog.board.commons.PostLikeVO;
import com.spring.codelog.board.mapper.IBoardMapper;
import com.spring.codelog.board.mapper.ISearchMapper;
import com.spring.codelog.board.model.BoardVO;
import com.spring.codelog.board.util.BoardUtil;
import com.spring.codelog.user.commons.profileImgVO;
import com.spring.codelog.user.model.UserVO;




@Service
public class BoardService implements IBoardService {
	@Autowired
	private IBoardMapper boardMapper;
	
	private BoardUtil util;

	@Override
	public int write(BoardVO vo) {
		
		
		 
		boardMapper.write(vo);
		
		return boardMapper.currentBoardId();

	}

		@Override
	public void image(ImgVO vo) {

             }

	// 게시글 상세보기
	@Override
	public BoardVO read(int boardId)  {
		return boardMapper.read(boardId);
	}
	
	// 게시글 수정 불러오기
	@Override
	public BoardVO modify(int boardId) {
		return boardMapper.modify(boardId);
	}

	// 게시글 수정
	@Override
	public void update(BoardVO vo) {
		boardMapper.update(vo);
	}

	// 게시글 삭제
	@Override
	public void delete(int boardId)  {
		boardMapper.delete(boardId);
	}

	// 게시글 전체 목록
	@Override
	public List<BoardVO> listAll()  {
		return boardMapper.listAll();
	}

	// 게시글 조회수 증가
	@Override
	public void increaseHit(int boardId, HttpSession session)  {
		System.out.println("전달?");
		long update_time = 0;
		// 세션에 저장된 조회시간 검색
		// 최초로 조회할 경우 세션에 저장된 값이 없기 때문에 if문은 실행X
		if (session.getAttribute("update_time_" + boardId) != null) {
			// 세션에서 읽어오기
			update_time = (long) session.getAttribute("update_time_" + boardId);
		}
		// 시스템의 현재시간을 current_time에 저장
		long current_time = System.currentTimeMillis();
		// 일정시간이 경과 후 조회수 증가 처리 24*60*60*1000(24시간)
		// 시스템현재시간 - 열람시간 > 일정시간(조회수 증가가 가능하도록 지정한 시간)
		if (current_time - update_time > 300 * 1000) {
			boardMapper.increaseHit(boardId);
			// 세션에 시간을 저장 : "update_time_"+boardId는 다른변수와 중복되지 않게 명명한 것
			session.setAttribute("update_time_" + boardId, current_time);

		}
	}

	
	//게시글 좋아요 증가(유저 기준 아님 상세보기 해당 게시글 기준임)
	@Override
	public void totalLikeUp(int boardId) {
		boardMapper.totalLikeUp(boardId);
	}

	//게시글 좋아요 감소(유저 기준 아님 상세보기 해당 게시글 기준임)
	@Override
	public void totalLikeDown(int boardId) {
		boardMapper.totalLikeDown(boardId);
	}
	@Override
	public int lastBno() {
		System.out.println("확인용");
		return boardMapper.lastbno();
	}
	
	@Override
	public List<BoardVO> search(String keyword) {
		 return boardMapper.search(keyword);
	}

	//탈퇴하는 사용자 모든 게시글 삭제
	@Override
	public void deleteAll(String userId) {
		boardMapper.deleteAll(userId);
	}

}

