package com.spring.codelog.user;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.codelog.board.model.BoardVO;
import com.spring.codelog.board.service.IBoardService;
import com.spring.codelog.user.model.UserVO;
import com.spring.codelog.user.service.IUserService;

import lombok.Getter;


@RestController
@RequestMapping("/image")
public class ImgController {
	
	@Autowired
	IUserService service;
	@Autowired
	IBoardService bservice;

	//프로필 이미지 파일 보여주기 요청
	@GetMapping("/{userId}")
	public ResponseEntity<byte[]> getUserImgFile(@PathVariable("userId") String userId) {
		System.out.println("프로필이미지 "+userId);
		String fileName = service.getUserImg(userId);
		System.out.println("fileName: " + fileName);
		
		File file;
		
		if(fileName == null || fileName.equals("null")) {
			file = new File("C:\\test\\upload\\user_icon.png");
			
		} else {
			file = new File("C:\\test\\upload\\" + fileName);
			System.out.println(file);
			
		}
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
		
	}
	
	

	
	
	
	//썸네일 이미지 파일 보여주기 요청
	@GetMapping("/display/{thumbnail}")
	public ResponseEntity<byte[]> getFile(@PathVariable("thumbnail") String thumbnail, HttpSession session) {
		String fileName = thumbnail;
		System.out.println("fileName: " + fileName);

		
		
		File file;
		
		if(fileName == null || fileName.equals("null")) {
			file = new File("C:\\test\\thumbnail\\codelog.png");
			
		} else {
			file = new File("C:\\test\\thumbnail\\" + fileName);
			System.out.println(file);
			
		}		
		
		

		ResponseEntity<byte[]> result = null;
		System.out.println(result);

		try {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;

	}
}
