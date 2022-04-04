package com.spring.codelog.board.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.codelog.board.mapper.IHomeMapper;
import com.spring.codelog.board.model.BoardVO;

@Service
public class HomeService implements IHomeService {

	@Autowired
	private IHomeMapper mapper;
	@Override
	public List<BoardVO> TPosters(String start, String end) {
		// TODO Auto-generated method stub
		System.out.println("start,end"+start+end);
		return mapper.TPosters(start,end);
	}
	
	@Override
	public List<BoardVO> TAPosters(int likes, String start, String end) {
		// TODO Auto-generated method stub
		System.out.println("start,end"+start+end);
		return mapper.TAPosters(likes, start, end);
	}
/*	
	@Override
	public BoardVO SelectOne(int i) {
		// TODO Auto-generated method stub
		return mapper.SelectOne(i);
	}
	
	@Override
	public BoardVO SelectOneT(int i) {
		// TODO Auto-generated method stub
		return mapper.SelectOneT(i);
	}
*/
	@Override
	public List<BoardVO> RPosters() {
		List<BoardVO> list = mapper.RPosters();
		//System.out.println("result: " + list);
		return list;
		
	}
	
	@Override
	public List<BoardVO> RAPosters(int i, int boardId) {
		// TODO Auto-generated method stub
		System.out.println("i값은: "+i+" boardId는 "+boardId);
		return mapper.RAPosters(i, boardId);
	}

	@Override
	public List<BoardVO> FPosters(int userNo) {
		// TODO Auto-generated method stub
		return mapper.FPosters(userNo);
	}
	
	@Override
	public List<BoardVO> FAPosters(int boardId, int userNo) {
		// TODO Auto-generated method stub
		return mapper.FAPosters(boardId, userNo);
	}


	@Override
	public int FPCount(String userId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int PCount() {
		// TODO Auto-generated method stub
		return 0;
	}

}

