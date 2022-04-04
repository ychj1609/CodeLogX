package com.spring.codelog.util.websocket.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class NotificationVO {
	private int notiNo;
	private String receiver;
	private String msg;
	private String sender;
	private Timestamp regDate;
	private String category;
	private int bno;

}
