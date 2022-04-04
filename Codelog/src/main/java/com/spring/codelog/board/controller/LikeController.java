package com.spring.codelog.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.codelog.board.commons.PostLikeVO;
import com.spring.codelog.board.service.IBoardService;
import com.spring.codelog.board.service.IPostLikeService;

@RestController
public class LikeController {
	
	@Autowired
	private IPostLikeService likeService;
	@Autowired
	private IBoardService boardService;
	
	@PutMapping("/likeUpdate")
	public Map<String, String> likeUpdate(@RequestBody PostLikeVO vo) {
		System.out.println("/likeUpdate: PUT");
		System.out.println("좋아요컨트롤러:" + vo);
		int boardId = vo.getBoardId();
		
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			likeService.likeUpdate(vo);
			
			if(vo.getPostLike() == 0) {
				boardService.totalLikeUp(boardId);
			} else {
				boardService.totalLikeDown(boardId);
			}
			
			map.put("result", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		
		return map;
		
	}

}