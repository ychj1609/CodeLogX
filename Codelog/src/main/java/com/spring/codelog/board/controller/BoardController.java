package com.spring.codelog.board.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.codelog.board.commons.PostLikeVO;
import com.spring.codelog.board.commons.TagVO;
import com.spring.codelog.board.model.BoardVO;
import com.spring.codelog.board.service.BoardService;

import com.spring.codelog.board.service.ISearchService;

import com.spring.codelog.board.service.ReplyService;



import com.spring.codelog.board.service.PostLikeService;
import com.spring.codelog.board.service.TagService;
import com.spring.codelog.user.model.UserVO;
import com.spring.codelog.util.websocket.model.NotificationVO;
import com.spring.codelog.util.websocket.servcice.NotificationService;


@Controller
@RequestMapping("/boardController")
public class BoardController {

   @Autowired
   BoardService service;
   @Autowired
   ReplyService service2;

   @Autowired
   NotificationService notiService;

   @Autowired
   PostLikeService likeService;

   @Autowired
   TagService tagService;
   
   @Autowired
   private ISearchService searchService;

   @GetMapping("/test")
   public String test() {
      return "board/temp";
   }

   @RequestMapping(value = "/getWrite", method = RequestMethod.GET)
   public String write(HttpServletRequest request ,Model model)
   {

      return "board/write";

   }
   @ResponseBody
   @RequestMapping(value ="/thumbnail", method = {RequestMethod.POST})
   public String thumb(MultipartHttpServletRequest mhsr,MultipartFile file)
   {
      UUID uuid = UUID.randomUUID();
      String uuids = uuid.toString().replaceAll("-", "");
      try {
         System.out.println("--------------------------보드컨트롤러썸네일-----------------");
         String uploadPath = "C:\\test\\thumbnail";
         String fileRealName = file.getOriginalFilename();   
         String fileExtension = fileRealName.substring(fileRealName.indexOf("."), fileRealName.length());
         String fileName = uuids + fileExtension;
         System.out.println("저장할 폴더 경로: " + uploadPath);
         System.out.println("실제 파일명: " + fileRealName);
         System.out.println("확장자: " + fileExtension);
         System.out.println("고유랜덤문자: " + uuids);
         System.out.println("변경해서 저장할 파일명: " + fileName);
         //업로드한 파일을 서버 컴퓨터의 저장한 경로 내에 실제로 저장
         File saveFile = new File(uploadPath + "\\" + fileName);         
         file.transferTo(saveFile);      
         System.out.println("통신성공");
         return fileName;
      } catch (Exception e) {
         System.out.println("업로드 중 에러 발생: " + e.getMessage());
         e.printStackTrace();
         return "false";

      }

   }

   @RequestMapping(value = "/write", method = {RequestMethod.POST})
   public String write(BoardVO vo, RedirectAttributes ra, HttpServletRequest hsr, MultipartFile file) {
      try {
         hsr.setCharacterEncoding("UTF-8");
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      }
      System.out.println("글 작성 요청");
      int boardId = service.write(vo);
      //태그등록 
      String tags = vo.getTags();
      String userId = vo.getUserId();
      String str = tags.replace(" ", "");
	  String st = str.replace("\"", "");
	  System.out.println("정제한 문자열"+st);
	  String[] eachTag = st.split(",");
	  for(int i = 0; i<eachTag.length; i++) {
			tagService.registTags(eachTag[i], userId,boardId);
		}
      
      ra.addFlashAttribute("msg", "글 작성 완료");
      return "redirect:/boardController/board?boardId=" + boardId;
   }

   
    // 01. 게시글 목록
    @RequestMapping("list")
    public ModelAndView list() throws Exception{ 
        List<BoardVO> list = service.listAll();
        // ModelAndView - 모델과 뷰
        ModelAndView mav = new ModelAndView();
        mav.setViewName("user/mypage"); // 뷰를 mypage.jsp로 설정
        mav.addObject("list", list); // 데이터를 저장
        return mav; // mypage.jsp로 List가 전달된다.
    }
   

   
    // 게시글 상세내용 조회, 게시글 조회수 증가 처리
    // @RequestParam : get/post방식으로 전달된 변수 1개
    // HttpSession 세션객체
    @RequestMapping(value="/board", method=RequestMethod.GET)
    public ModelAndView home(@RequestParam int boardId, HttpSession session) {
        // 조회수 증가 처리
       if(session.getAttribute("loginSession") != null)
        service.increaseHit(boardId, session);
        
        // 모델(데이터)+뷰(화면)를 함께 전달하는 객체
        ModelAndView mav = new ModelAndView();
        
        int like = 0;
        
        
        if(session.getAttribute("loginSession") != null) {
           
           //좋아요 처리
           PostLikeVO vo = new PostLikeVO();
           UserVO user = (UserVO) session.getAttribute("loginSession");
           
           String viewUserId = user.getUserId();
           System.out.println("이 글 보고 있는 사용자 아이디: " + viewUserId);
           
           vo.setBoardId(boardId);
           vo.setViewUserId(viewUserId);
           
           
           int checkNum = likeService.likeCount(vo);
           
           if(checkNum == 0) {
              likeService.likeInsert(vo);
           } else {
              like = likeService.getLikeInfo(vo);
           }
           
           //알림 가져오기
          List<NotificationVO> alarmList = new ArrayList<>();
          alarmList = notiService.alarm(viewUserId);
           System.out.println("알림받을사람: " + viewUserId);
           mav.addObject("alarm", alarmList);
           mav.addObject("countAlarm", notiService.countAlarm(viewUserId));
           //알림가져오기 끝
           
        }
        
        List<String> tagList =  tagService.listbybId(boardId);
        // 뷰의 이름
        mav.setViewName("board/board");
        mav.addObject("tagList", tagList);
        System.out.println("태그리스트: "+tagList);

        

        
        // 뷰의 이름
        mav.setViewName("board/board");
        
        BoardVO vo = service.read(boardId);
          List<BoardVO> list = new ArrayList<>();

      

      if(tagList.size() != 0) {
         String board_tag = tagList.get(0);
           list = searchService.search(board_tag);
      }
        
        // 뷰에 전달할 데이터
        mav.addObject("dto", vo);
        mav.addObject("searchList", list);
        mav.addObject("postLike", like);
        return mav;
    }
   
    
    //  게시글 수정 불러오기
    @RequestMapping(value="/modify", method=RequestMethod.GET)
    public ModelAndView home2(@RequestParam int boardId, HttpSession session) {
        // 모델(데이터)+뷰(화면)를 함께 전달하는 객체
        ModelAndView mav2 = new ModelAndView();
        // 뷰의 이름
        mav2.setViewName("board/modify");
        // 뷰에 전달할 데이터
        mav2.addObject("dto2", service.modify(boardId));
        return mav2;
    }
    
    
    // 게시글 수정
    // 폼에서 입력한 내용들은 @ModelAttribute BoardVO vo로 전달됨
    @RequestMapping(value="update", method=RequestMethod.POST)
    public String update(BoardVO vo) {
       System.out.println("글 수정 요청");
       System.out.println(vo);
        service.update(vo);
        //태그수정
        String tags = vo.getTags();
        String str = tags.replace(" ", "");
      String st = str.replace("\"", "");
      System.out.println("정제한 문자열"+st);
      String[] eachTag = st.split(",");
      System.out.println(Arrays.toString(eachTag));
      tagService.deleteTags(vo.getBoardId());
      for(int i = 0; i<eachTag.length; i++) {
         tagService.registTags(eachTag[i], vo.getUserId(), vo.getBoardId());
      }

      return "redirect:/boardController/board?boardId=" + vo.getBoardId();
   }

   //  게시글 삭제
   @PostMapping("/delete")
   public String delete(@RequestParam int boardId) {
      System.out.println("게시물 삭제: 보드번호"+ boardId);
      service.delete(boardId);
      tagService.deleteTags(boardId);
      return "redirect:/";
   }



}