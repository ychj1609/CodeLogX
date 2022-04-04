package com.spring.codelog.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.codelog.board.commons.PostLikeVO;
import com.spring.codelog.board.mapper.IPostLikeMapper;

@Service
public class PostLikeService implements IPostLikeService {
	
	@Autowired
	private IPostLikeMapper mapper;

	@Override
	public int likeCount(PostLikeVO vo) {
		return mapper.likeCount(vo);
	}
	
	@Override
	public void likeInsert(PostLikeVO vo) {
		mapper.likeInsert(vo);
	}

	@Override
	public int getLikeInfo(PostLikeVO vo) {
		return mapper.getLikeInfo(vo);
	}

	@Override
	public void likeUpdate(PostLikeVO vo) {
		mapper.likeUpdate(vo);
	}

}