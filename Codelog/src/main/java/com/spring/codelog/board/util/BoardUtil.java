package com.spring.codelog.board.util;

import javax.servlet.http.HttpServletRequest;


public class BoardUtil {

	public boolean ContainImage(HttpServletRequest hsr) //jsp 페이지에 게시글 이미지 등록 여부 확인
	{
		if( hsr.getParameter("image") != null) return true;
		else return false;
	}

}