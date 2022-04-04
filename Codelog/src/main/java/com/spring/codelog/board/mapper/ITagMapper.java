package com.spring.codelog.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.codelog.board.commons.TagVO;
import com.spring.codelog.board.model.BoardVO;

public interface ITagMapper {
	
	//태그 등록
	void registTags(@Param("boardId") int boardId,@Param("userId") String userId,@Param("tagName") String tagName);
	
	//태그 조회
	List<String> listbybId(int boardId);
	
	//회원아이디로 태그조회
	List<String> listbyuId(String userId);
	
	
	//태그삭제
	void deleteTags(int boardId);
	
	//태그갯수
	List<Map<String, Object>> countTags(String userId);
	
}
