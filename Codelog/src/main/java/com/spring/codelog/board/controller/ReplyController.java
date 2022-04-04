package com.spring.codelog.board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.codelog.board.model.ReplyVO;
import com.spring.codelog.board.service.ReplyService;


@RequestMapping("/reply")
@RestController
public class ReplyController {
	
	@Autowired
	ReplyService service;
	// 모댓글 작성
	
	@RequestMapping(value = "/replyWrite", method = RequestMethod.POST)
	public int replyWrite(@RequestBody ReplyVO vo, HttpSession session) {
		System.out.println("댓글 진입은했다!");
		System.out.println("들어온 댓글 내용은? "+vo);
		
		
		return service.replyWrite(vo);
	}

	// 답글 작성
	
	@RequestMapping(value = "/rereplyWrite")
	public int rereplyWrite(@RequestBody ReplyVO vo, HttpSession session) {
		System.out.println("대댓글 진입은했다!");
		System.out.println("들어온 댓글 내용은? "+vo);
		
		return service.rereplyWrite(vo);   
	}

	// 댓글 리스트
	
	@RequestMapping(value = "/replyList", method = RequestMethod.GET)
	public List<ReplyVO> replyList(int bno, HttpSession session) {
		System.out.println("/reply/replyList");
		System.out.println("댓글 리스트"+ service.replyList(bno));
	    return service.replyList(bno);
	}

	// 모댓글 삭제
	
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
	public int deleteReply(@RequestBody int no, @RequestBody int bno) {
		System.out.println("deleteReply 진입");
	    return service.DeleteReply(no, bno);
	}
	
	// 댓글 수정
	
		@RequestMapping(value = "/replyModify", method = RequestMethod.POST)
		public void replyModify(@RequestBody Map<String, String> info) {
			System.out.println("replyModify 진입");
			int no = Integer.parseInt(info.get("no"));
		    service.ModifyReply(no, info.get("content"));	
		    
		
	}
		
		

	// 답글 삭제
	
	@RequestMapping(value = "/deleteReReply", method = RequestMethod.POST)
	public int deleteReReply(@RequestBody Map<String, Integer> info) {
		 return  service.DeleteReReply(info.get("no"), info.get("bno"));
	}

}
