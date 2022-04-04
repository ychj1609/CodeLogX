package com.spring.codelog;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.codelog.board.mapper.IBoardMapper;
import com.spring.codelog.board.mapper.IHomeMapper;
import com.spring.codelog.board.model.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/mvc-config.xml")
public class FreeBoardMapperTest {

	
	   @Autowired
	   private IBoardMapper mapper;
	   
	   @Test
	   public void registTest() {
		   
		   
		   Date nowDate = new Date(); 
		   System.out.println("포맷 지정 전 : " + nowDate); 
		   SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM/dd"); //원하는 데이터 포맷 지정 String strNowDate = simpleDateFormat.format(nowDate);

			   
			   
		   Timestamp timestamp = new Timestamp(System.currentTimeMillis()-7);
		   
		   
	      for(int i=1; i<=30; i++) {
	         BoardVO vo = new BoardVO();
	         
	         vo.setUserNo(i);
	         vo.setUserId("qweasdzxc"+i);
	         vo.setTitle("테스트 제목 " + i);
	         vo.setWriter("작성자"+i);
	         vo.setContent("테스트 글쓰기 내용입니다. " + i);
	         vo.setTags("태그"+i);
	         vo.setImgPath("이미지경로"+i);
	         vo.setHit(i);
	         vo.setLikes(i);
	         vo.setRegDate(timestamp);
	         vo.setPreview("미리보기"+i);
	         vo.setThumbnail("썸네일경로"+i);
	         vo.setViewAll("1");
	         vo.setRecnt(i);
				/* vo.setboardId(i); */
	         mapper.write(vo);
	      }
	   }


}
