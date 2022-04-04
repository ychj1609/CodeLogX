package com.spring.codelog.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.codelog.user.commons.profileImgVO;
import com.spring.codelog.user.mapper.IUserMapper;
import com.spring.codelog.user.model.UserVO;

@Service
public class UserService implements IUserService {
	
	@Autowired
	private IUserMapper mapper;

	@Override
	public int checkId(String userId) {
		return mapper.checkId(userId);
	}

	@Override
	public void join(UserVO user) {
		mapper.join(user);
	}

	@Override
	public UserVO selectOne(String userId) {
		return mapper.selectOne(userId);
	}

	@Override
	public void updateProfileImg(profileImgVO vo) {
		mapper.updateProfileImg(vo);
	}
	
	@Override
	public void nickChange(UserVO vo) {
		mapper.nickChange(vo);
	}
	
	@Override
	public void updateUser(UserVO vo) {
		mapper.updateUser(vo);
	}
	
	@Override
	public void delete(String userId) {
		mapper.delete(userId);
	}

	@Override
	public UserVO selectUser(String nickname) {
		return mapper.selectUser(nickname);
	}

	@Override
	public UserVO getInfo(String userId) {
		return mapper.getInfo(userId);
	}

@Override
public String getUserImg(String userId) {
	// TODO Auto-generated method stub
	return mapper.getUserImg(userId);
}









}