package com.spring.codelog.board.service;

import com.spring.codelog.board.commons.PostLikeVO;

public interface IPostLikeService {
	
	//좋아요 카운트(글 보고있는 유저가 이 글을 본 적이 있는지. 필요한 이유는 안 본 글이면 좋아요 컬럼에 데이터가 없다.)
	public int likeCount(PostLikeVO vo);
	
	//좋아요 생성해주기
	public void likeInsert(PostLikeVO vo);
	
	//좋아요 정보
	public int getLikeInfo(PostLikeVO vo);
	
	//좋아요 업데이트
	public void likeUpdate(PostLikeVO vo);

}