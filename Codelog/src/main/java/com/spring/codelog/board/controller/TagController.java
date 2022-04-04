
package com.spring.codelog.board.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.codelog.board.commons.TagVO;
import com.spring.codelog.board.service.IBoardService;
import com.spring.codelog.board.service.ITagService;

import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/tag")
public class TagController {
	


	@Autowired
	ITagService service;
	

	
	@Autowired
	IBoardService boardService;
	
//	@PostMapping("/regist")
//	public String regist(@RequestBody Map<String, String> info) {
//		String tags = info.get("tags");
//		String userId = info.get("userId");
//		System.out.println("태그들: "+ info.get("tags"));
//		//태그 나눠주기
//		int boardId = boardService.lastBno();
//		System.out.println("글 번호" + boardId);
//		System.out.println("글쓴이" + userId);
//		String str = tags.replace(" ", "");
//		String st = str.replace("\"", "");
//		System.out.println("정제한 문자열"+st);
//		String[] eachTag = st.split(",");
//		System.out.println(Arrays.toString(eachTag));
//		for(int i = 0; i<eachTag.length; i++) {
//			service.registTags(eachTag[i], userId,boardId);
//		}
//		
//			
//		
//		return "tag";
//	}
//	

}
