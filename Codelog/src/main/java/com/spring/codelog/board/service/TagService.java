package com.spring.codelog.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.codelog.board.commons.TagVO;
import com.spring.codelog.board.mapper.IBoardMapper;
import com.spring.codelog.board.mapper.ITagMapper;
import com.spring.codelog.board.model.BoardVO;

@Service
public class TagService implements ITagService {

	@Autowired
	ITagMapper mapper;
	
	@Autowired
	IBoardMapper bmapper;
	
	@Override
	public void registTags(String tagName, String userId,int boardId) {
		mapper.registTags(boardId, userId, tagName);
		
	}

	@Override
	public List<String> listbybId(int boardId) {
		return mapper.listbybId(boardId);
	}

	@Override
	public List<String> listbyuId(String userId) {
		return mapper.listbyuId(userId);
	}
	
	@Override
	public void deleteTags(int boardId) {
		mapper.deleteTags(boardId);
	}

   @Override
  public List<Map<String, Object>> countTags(String userId) {
	return mapper.countTags(userId);
}
	


}
