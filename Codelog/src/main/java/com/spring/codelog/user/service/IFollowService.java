package com.spring.codelog.user.service;

import java.util.List;

import com.spring.codelog.user.commons.FollowVO;

public interface IFollowService {
	
	//팔로우기능
	void follow(FollowVO fvo);
	
	//언팔로우
	void unfollow(FollowVO fvo);
	
	//팔로우 유무
	int isFollow(FollowVO fvo);
	
	//팔로우 리스트 조회
	List<FollowVO> selectActiveUserList(int activeUser);
	
	//팔로워 리스트 조회
	List<FollowVO> selectPassiveUserList(int passiveUser);
	
	//탈퇴시 팔로우 삭제
	void deleteUserAllFollow(int activeUser);
}
