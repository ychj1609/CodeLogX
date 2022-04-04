package com.spring.codelog.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.codelog.board.model.ReplyVO;

public interface IReplyMapper {
	
	
	public void replyWrite(@Param("bno") int bno,@Param("writer") String writer,@Param("content") String content,@Param("userNo") int userNo);
	public void	rereplyWrite(@Param("bno") int bno,@Param("grp") int grp, @Param("grps") int grps,@Param("writer") String writer,@Param("content") String content,@Param("userNo") int userNo);
	public void replyUp(@Param("bno") int bno);
	public	List<ReplyVO> replyList(@Param("bno") int bno);
	public void replyNotDelete(@Param("no") int no);
	public void replyDown(@Param("bno") int bno);
	public int getGrps(@Param("grp") int grp);
	public int getRecnt(@Param("bno") int bno);
	public void ModifyReply(@Param("no") int no, @Param("content") String content);

   
}
