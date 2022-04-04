package com.spring.codelog.user;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.codelog.user.commons.FollowVO;
import com.spring.codelog.user.model.UserVO;
import com.spring.codelog.user.service.IFollowService;
import com.spring.codelog.user.service.IUserService;

@Controller
public class FollowController {
	
	@Autowired
	private IFollowService fservice;
	
	@Autowired 
	private IUserService uservice;
	
	//팔로우기능
	@ResponseBody
	@PostMapping("/follow/{userId}")
	public String follow(@PathVariable("userId") String id, HttpSession session, Model model) {
		System.out.println("팔로우 요청: "+ id);
		
		UserVO activeUser = uservice.selectOne(((UserVO) session.getAttribute("loginSession")).getUserId()); 
		UserVO passiveUser = uservice.selectOne(id);
		FollowVO following = new FollowVO();
		following.setActiveUser(activeUser.getUserNo());
		following.setPassiveUser(passiveUser.getUserNo());
		fservice.follow(following);
		return "followOk";
	}
	
	//언팔로우 기능
	@ResponseBody
	@PostMapping("/unfollow/{userId}")
	public String unfollow(@PathVariable("userId") String id, HttpSession session, Model model) {
		UserVO activeUser = uservice.selectOne(((UserVO) session.getAttribute("loginSession")).getUserId()); 
		UserVO passiveUser = uservice.selectOne(id);
		FollowVO following = new FollowVO();
		following.setActiveUser(activeUser.getUserNo());
		following.setPassiveUser(passiveUser.getUserNo());
		fservice.unfollow(following);
		System.out.println();
		return "unfollowOk";
	}
	

	
}







