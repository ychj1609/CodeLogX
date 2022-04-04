package com.spring.codelog.user.mapper;

import com.spring.codelog.user.commons.profileImgVO;
import com.spring.codelog.user.model.UserVO;

public interface IUserMapper {

	//아이디 중복 체크 기능
	int checkId(String userId);
	
	//회원 가입 기능
	void join(UserVO user);
	
	//회원정보 조회 기능
	UserVO selectOne(String userId);
	
	//프로필 이미지 업로드 기능
	void updateProfileImg(profileImgVO vo);
	
	//회원정보 수정 기능
	void updateUser(UserVO vo);
	
	//닉네임 & 자기소개 수정 기능
	void nickChange(UserVO vo);

	//회원 탈퇴 기능
	void delete(String userId);
	
	//닉네임으로 정보 가져오는 기능
	UserVO selectUser(String nickname);

	//마이페이지 정보 
	UserVO getInfo(String userId);
	
	String getUserImg(String userId);
	


}