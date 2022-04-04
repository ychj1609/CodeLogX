package com.spring.codelog.util.websocket.mapper;

import java.util.List;

import com.spring.codelog.util.websocket.model.NotificationVO;

public interface INotificationMapper {

	//알림메세지 저장 기능
	void saveNotification(NotificationVO vo);

	//알림메세지 조회 기능
	List<NotificationVO> alarm(String receiver);
	
	//알림메세지 개수 조회 기능
	int countAlarm(String receiver);

	//알림메세지 삭제 기능
	void deleteNotification(int notiNo);

}
