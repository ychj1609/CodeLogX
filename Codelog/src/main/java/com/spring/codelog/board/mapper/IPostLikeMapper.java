package com.spring.codelog.board.mapper;


import com.spring.codelog.board.commons.PostLikeVO;

public interface IPostLikeMapper {

	//좋아요 카운트(글 보고있는 유저가 이 글을 본 적이 있는지. 필요한 이유는 안 본 글이면 좋아요 컬럼에 데이터가 없다.)
	public int likeCount(PostLikeVO vo);

	//좋아요 생성해주기(좋아요를 누른 적이 없다면 좋아요 테이블에 0으로 값 입력해서 테이블 로우 생성)
	public void likeInsert(PostLikeVO vo);
	
	//좋아요 정보(좋아요 눌렀는지 안눌렀는지 숫자로 반환해줌 안누름:0, 누름:1)
	public int getLikeInfo(PostLikeVO vo);

	//좋아요 업데이트(좋아요 누르면 1, 누른 게시물 다시 누르면 0으로)
	public void likeUpdate(PostLikeVO vo);

}