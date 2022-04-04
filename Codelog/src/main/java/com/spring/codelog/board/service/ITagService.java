package com.spring.codelog.board.service;

import java.util.List;
import java.util.Map;

import com.spring.codelog.board.commons.TagVO;
import com.spring.codelog.board.model.BoardVO;

public interface ITagService {
	
	//태그 등록
	void registTags(String tagName, String userId, int boardId);
	
	//태그 조회
	List<String> listbybId(int boardId);
	
	//회원아이디로 태그조회
	List<String> listbyuId(String userId);
	
	
	//태그삭제
	void deleteTags(int boardId);
    
	List<Map<String, Object>> countTags(String userId);
}
