package com.spring.codelog.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.codelog.board.mapper.ISearchMapper;
import com.spring.codelog.board.model.BoardVO;

@Service
public class SearchService implements ISearchService {
	
	@Autowired
	private ISearchMapper mapper;

	@Override
	public List<BoardVO> search(String keyword) {
		if((keyword.charAt(0)) == '#') {
			String nkeyword = keyword.substring(1);
			System.out.println("#을뺀 키워드 :"+ nkeyword);
			return mapper.searchByTag(nkeyword);
		} else {}
		System.out.println("글검색 키워드"+ keyword);
		return mapper.search(keyword);
	}
	
	@Override
	public List<BoardVO> searchId(String userId) {
		// TODO Auto-generated method stub
		return mapper.searchId(userId);
	}

	@Override
	public List<BoardVO> searchMypage(String keyword, String userId) {
		
		return mapper.searchMypage(keyword, userId);
	}

	@Override
	public List<BoardVO> searchByTag(String keyword) {
		return mapper.searchByTag(keyword);
	}

}
