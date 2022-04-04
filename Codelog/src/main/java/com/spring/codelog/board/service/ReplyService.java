package com.spring.codelog.board.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.spring.codelog.board.mapper.IReplyMapper;
import com.spring.codelog.board.model.ReplyVO;



@Service
public class ReplyService {

	@Autowired
	private IReplyMapper mapper;
	
	// 댓글 작성
	public int replyWrite(ReplyVO vo) {
		// p_reply 테이블에 값 추가
		System.out.println("서비스로 넘어온 값은 "+vo);
		mapper.replyWrite(vo.getBno(), vo.getWriter(), vo.getContent(), vo.getUserNo());
		
		// proj_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅			
		mapper.replyUp(vo.getBno());
		
		return mapper.getRecnt(vo.getBno());

	}
	
	// 대댓글 작성
	public int rereplyWrite(ReplyVO vo) {
		// p_reply 테이블에 값 추가
		int grps = mapper.getGrps(vo.getGrp());
		System.out.println("grps의 값은? "+grps);
		
		mapper.rereplyWrite(vo.getBno(), vo.getGrp(), grps, vo.getWriter(), vo.getContent(),vo.getUserNo());
		
		// proj_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅			
		mapper.replyUp(vo.getBno());
		
		return mapper.getRecnt(vo.getBno());
	}
	
	// 댓글 리스트
	public List<ReplyVO> replyList(int bno){
	//List에 댓글 넣기	
		List<ReplyVO> replyList = new ArrayList<ReplyVO>();
		
		replyList = mapper.replyList(bno);
		
		return replyList;
	}
	
	// 모댓글 삭제
	public int DeleteReply(int no, int bno ) {
		// proj_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅		
			mapper.replyDown(bno);
			
			// 모댓글 삭제  
			mapper.replyNotDelete(no);	
			System.out.println("recnt값은 "+mapper.getRecnt(bno));
			return mapper.getRecnt(bno);

	}
	// 댓글 수정
		public void ModifyReply(int no, String content ) {
			
				
				// 모댓글 삭제  
				mapper.ModifyReply(no,content);

		}
	
	// 대댓글 삭제
	public int DeleteReReply(int no, int bno) {
		// proj_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅		
		mapper.replyDown(bno);
		
		// 대댓글 삭제  
		mapper.replyNotDelete(no);	
		System.out.println("recnt값은 "+mapper.getRecnt(bno));

		return mapper.getRecnt(bno);

	}
	
	
	
	
}