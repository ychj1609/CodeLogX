package com.spring.codelog;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.codelog.board.mapper.BoardMapper;
import com.spring.codelog.board.model.BoardVO;
import com.spring.codelog.board.service.HomeService;
import com.spring.codelog.user.model.UserVO;
import com.spring.codelog.util.websocket.model.NotificationVO;
import com.spring.codelog.util.websocket.servcice.INotificationService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
    		  BoardMapper boardmap;
	@Autowired
	private	HomeService service;
	
	@Autowired
	private INotificationService notiService;
	
   @RequestMapping(value = "/", method = RequestMethod.GET)
   public String home(Locale locale, Model model, String fromT, HttpServletRequest request, String allChk) {    
	   
	   System.out.println("---------------------------GET:/ HOME:RECENT-------------------------");
	 
	   
	      model.addAttribute("recent", true);
	      model.addAttribute("trending", false);
	      model.addAttribute("i", 3);
	      
	      
	   
	   HttpSession session = request.getSession();
	   if(session.getAttribute("loginSession")!=null) {
		   UserVO login = (UserVO)session.getAttribute("loginSession");
		   
		
		 
		   
		   if(allChk == null) {
			   model.addAttribute("allChk", "fol");
			   model.addAttribute("Posters", service.FPosters(login.getUserNo()));
		   }
		   else
		   {
			   if(allChk.equals("fol")) {
				   model.addAttribute("allChk", "fol");
				   model.addAttribute("Posters", service.FPosters(login.getUserNo()));

			   }else if(allChk.equals("all")) {
				   model.addAttribute("allChk", "all");
				   model.addAttribute("Posters", service.RPosters());
		    }

				   
				   }
			   
		   System.out.println("------------------------------------------------------");
		   
		   //알림 가져오기
		   String receiver = login.getUserId();
		   List<NotificationVO> alarmList = new ArrayList<>();
		   alarmList = notiService.alarm(receiver);
		   model.addAttribute("alarm", alarmList);
		   model.addAttribute("countAlarm", notiService.countAlarm(receiver));
		   //알림가져오기 끝

		   
		   return "home";
		   
		   
	   }
	   
	   model.addAttribute("Posters", service.RPosters());
	  
     
	   System.out.println("------------------------------------------------------");
	   

      return "home";
   }
   
   @ResponseBody
   @RequestMapping(value = "/radd", method = RequestMethod.POST)
   public List<BoardVO> RHome(Model model, @RequestBody Map<String,Integer> info, 
		   HttpServletRequest request, 
			HttpServletResponse response) {
	   
	   System.out.println("--------------------POST:/radd HOME:RECENT:ADD--------------------");
	   
	   List<BoardVO> list = new ArrayList<BoardVO>();
	   
	   
	   HttpSession session = request.getSession();
	   if(session.getAttribute("loginSession")!=null) {
		   UserVO login = (UserVO)session.getAttribute("loginSession");
		   
		   //알림 가져오기
		   String receiver = login.getUserId();
		   List<NotificationVO> alarmList = new ArrayList<>();
		   alarmList = notiService.alarm(receiver);
		   model.addAttribute("alarm", alarmList);
		   model.addAttribute("countAlarm", notiService.countAlarm(receiver));
		   //알림가져오기 끝
		   if(info.get("allChk")==2) {
		 
		   list = service.FAPosters(info.get("boardId"),login.getUserNo());
		   System.out.println("-----------------------------------------------------------------------");

		   return list;
		   }
		   else if(info.get("allChk")==1) 
		   {
			 
			   list = service.RAPosters(info.get("i"),info.get("boardId"));			   
			   System.out.println("-----------------------------------------------------------------------");

			   return list;
			   }
		   
	   }
	   
	   
	   
	   list = service.RAPosters(info.get("i"),info.get("boardId"));
	   
	   
	   
	   System.out.println("-----------------------------------------------------------------------");

	return list;

   }
   
   
   @ResponseBody
   @RequestMapping(value = "/tadd", method = RequestMethod.POST)
   public List<BoardVO> THome(Model model, @RequestBody Map<String,Integer> info,
		   HttpServletRequest request, 
			HttpServletResponse response) {
	   
	   System.out.println("--------------------POST:/TAdd HOME:TRENDING:ADD--------------------");
	   
	   HttpSession session = request.getSession();
	   if(session.getAttribute("loginSession") != null) {
		   //알림 가져오기
		   UserVO user = (UserVO) session.getAttribute("loginSession");
		   List<NotificationVO> alarmList = new ArrayList<>();
		   String receiver = user.getUserId();
		   alarmList = notiService.alarm(receiver);
		   System.out.println("알림받을사람: " + receiver);
		   model.addAttribute("alarm", alarmList);
		   model.addAttribute("countAlarm", notiService.countAlarm(receiver));
		   //알림가져오기 끝
	   }

	   
	   List<BoardVO> list = new ArrayList<BoardVO>();
	   
	   

	   System.out.println("기간은?: "+info.get("period"));
	   Calendar calendar = Calendar.getInstance();
	   if(info.get("period") == null) {
		   calendar.add(Calendar.DATE, -7);
		   model.addAttribute("period", "week");

	   }else  {
	   if(info.get("period") == 2) {
	   calendar.add(Calendar.DATE, -7);
	   model.addAttribute("period", "week");

	   }else if(info.get("period") == 3) {
	   calendar.add(Calendar.MONTH, -1);
	   model.addAttribute("period", "month");


	   }else if(info.get("period") == 4) {
	   calendar.add(Calendar.YEAR, -1);
	   model.addAttribute("period", "year");

	   
	   }else if(info.get("period") == 1) {
	   calendar.add(Calendar.DATE, -1);
	   model.addAttribute("period", "day");
	   }
	   }
	   Date date = calendar.getTime();
	   
	   String pattern = "yy/MM/dd";
	   SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
	   String start = simpleDateFormat.format(date);
	   String end = simpleDateFormat.format(new Date());
	 
	   list = service.TAPosters(info.get("likes"),start, end);

	   System.out.println("-----------------------------------------------------------------------");

	   
	return list;

   }
   
   @RequestMapping(value = "/", method = RequestMethod.POST)
   public String home2(Locale locale, Model model, String fromT, HttpServletRequest request, String allChk) {
	   
	   System.out.println("---------------------------POST:/ HOME:RECENT-------------------------");

	      model.addAttribute("recent", true);
	      model.addAttribute("trending", false);
	     
	   
	   HttpSession session = request.getSession();
	   if(session.getAttribute("loginSession")!=null) {
		   UserVO login = (UserVO)session.getAttribute("loginSession");
		   
		   //알림 가져오기
		   String receiver = login.getUserId();
		   List<NotificationVO> alarmList = new ArrayList<>();
		   alarmList = notiService.alarm(receiver);
		   model.addAttribute("alarm", alarmList);
		   model.addAttribute("countAlarm", notiService.countAlarm(receiver));
		   //알림가져오기 끝
		   
		   if(allChk == null) {
			   model.addAttribute("allChk", "fol");
			   model.addAttribute("Posters", service.FPosters(login.getUserNo()));
		   }
		   else
		   {
			   if(allChk.equals("fol")) {
				   model.addAttribute("allChk", "fol");
				   model.addAttribute("Posters", service.FPosters(login.getUserNo()));

			   }else if(allChk.equals("all")) {
				   model.addAttribute("allChk", "all");
				   model.addAttribute("Posters", service.RPosters());
		    }

		   
		   }
		   
		  
		   System.out.println("-----------------------------------------------------------------------");

		   return "home";

		   
	   }
	   model.addAttribute("Posters", service.RPosters());
	 
    
	   System.out.println("-----------------------------------------------------------------------");

      return "home";
   }
   
   @RequestMapping(value = "/trending", method = RequestMethod.GET)
   public String trending(Locale locale, Model model, String fromR, String period, HttpServletRequest request) {
	   
	   HttpSession session = request.getSession();
	   if(session.getAttribute("loginSession") != null) {
		   UserVO user = (UserVO) session.getAttribute("loginSession");
		   //알림 가져오기
		   String receiver = user.getUserId();
		   List<NotificationVO> alarmList = new ArrayList<>();
		   alarmList = notiService.alarm(receiver);
		   model.addAttribute("alarm", alarmList);
		   model.addAttribute("countAlarm", notiService.countAlarm(receiver));
		   //알림가져오기 끝
	   }
	   
	   //service.TPosters(); 
	   Calendar calendar = Calendar.getInstance();
	   if(period ==null) {
		   calendar.add(Calendar.DATE, -7);
		   model.addAttribute("period", "week");

	   }else  {
		   if(period.equals("week")) {
			   calendar.add(Calendar.DATE, -7);
			   model.addAttribute("period", "week");

			   }else if(period.equals("month")) {
			   calendar.add(Calendar.MONTH, -1);
			   model.addAttribute("period", "month");


			   }else if(period.equals("year")) {
			   calendar.add(Calendar.YEAR, -1);
			   model.addAttribute("period", "year");

			   
			   }else if(period.equals("day")) {
	   calendar.add(Calendar.DATE, -1);
	   model.addAttribute("period", "day");
	   }
	   }
	   Date date = calendar.getTime();
	   
	   String pattern =  "yy/MM/dd";
	   SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
	   String start = simpleDateFormat.format(date);
	   String end = simpleDateFormat.format(new Date());

	   model.addAttribute("Posters", service.TPosters(start, end));
	 
      model.addAttribute("trending", true);
      model.addAttribute("recent", false);
    
      return "home";
   }
   
   @RequestMapping(value = "/trending", method = RequestMethod.POST)
   public String trending2(Locale locale, Model model, String fromR, String period, HttpServletRequest request) {
	   
	   HttpSession session = request.getSession();
	   if(session.getAttribute("loginSession") != null) {
		   UserVO user = (UserVO) session.getAttribute("loginSession");
		   //알림 가져오기
		   String receiver = user.getUserId();
		   List<NotificationVO> alarmList = new ArrayList<>();
		   alarmList = notiService.alarm(receiver);
		   model.addAttribute("alarm", alarmList);
		   model.addAttribute("countAlarm", notiService.countAlarm(receiver));
		   //알림가져오기 끝
	   }
	   
	   
	   System.out.println("--------------------POST:/trending HOME:TRENDING--------------------");

	   
	   Calendar calendar = Calendar.getInstance();
	   if(period == null) {
		   calendar.add(Calendar.DATE, -7);
		   model.addAttribute("period", "week");

	   }else  {
	   if(period.equals("week")) {
	   calendar.add(Calendar.DATE, -7);
	   model.addAttribute("period", "week");

	   }else if(period.equals("month")) {
	   calendar.add(Calendar.MONTH, -1);
	   model.addAttribute("period", "month");


	   }else if(period.equals("year")) {
	   calendar.add(Calendar.YEAR, -1);
	   model.addAttribute("period", "year");

	   
	   }else if(period.equals("day")) {
	   calendar.add(Calendar.DATE, -1);
	   model.addAttribute("period", "day");
	   }
	   }
	   Date date = calendar.getTime();
	   
	   String pattern =  "yy/MM/dd";
	   SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
	   String start = simpleDateFormat.format(date);
	   String end = simpleDateFormat.format(new Date());
	
	   model.addAttribute("Posters", service.TPosters(start, end));
	 
      model.addAttribute("trending", true);
      model.addAttribute("recent", false);
     
      
	   System.out.println("-----------------------------------------------------------------------");
	   
      return "home";
   }
 
   
   @RequestMapping(value = "/a", method = RequestMethod.GET)
   public String a( Model model) {
   return "ajax_page";
   }
   
   
   
}
