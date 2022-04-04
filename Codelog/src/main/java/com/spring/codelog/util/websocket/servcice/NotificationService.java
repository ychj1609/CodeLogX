package com.spring.codelog.util.websocket.servcice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.codelog.util.websocket.mapper.INotificationMapper;
import com.spring.codelog.util.websocket.model.NotificationVO;

@Service
public class NotificationService implements INotificationService {
	
	@Autowired
	private INotificationMapper notiMapper;

	@Override
	public void saveNotification(NotificationVO vo) {
		System.out.println("알림 확인 "+vo);
		notiMapper.saveNotification(vo);
	}

	@Override
	public List<NotificationVO> alarm(String receiver) {
		return notiMapper.alarm(receiver);
	}
	
	@Override
	public int countAlarm(String receiver) {
		return notiMapper.countAlarm(receiver);
	}

	@Override
	public void deleteNotification(int notiNo) {
		notiMapper.deleteNotification(notiNo);
	}

}
