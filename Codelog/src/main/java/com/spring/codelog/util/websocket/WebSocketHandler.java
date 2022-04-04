package com.spring.codelog.util.websocket;

import java.util.Arrays;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.codelog.user.model.UserVO;
import com.spring.codelog.util.websocket.model.NotificationVO;
import com.spring.codelog.util.websocket.servcice.INotificationService;


@Repository
public class WebSocketHandler extends TextWebSocketHandler {
   
   @Autowired
   private INotificationService notiService;

   //로그인중인 유저 1:1
   private Map<String, WebSocketSession> users = new ConcurrentHashMap<>();

   //웹소켓 클라이언트와 서버 연결되었을 때 호출
   @Override
   public void afterConnectionEstablished(WebSocketSession session) throws Exception {
      String senderId = getLoginId(session); //접속한 유저의 http세션을 조회해서 id를 얻음. 메서드 맨 밑에 있음.
      if(StringUtils.isNotEmpty(senderId)) { //로그인 한 경우
         System.out.println("소켓 연결 됨: " + senderId);
         users.put(senderId, session); //로그인중인 개별 유저 저장
      }

   }

   //웹소켓 클라이언트가 텍스트 메시지를 전송할 때(클라이언트가 데이터 전송) 호출
   @Override
   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
      String senderId = getLoginId(session);

      //좋아요 알림 보내기
      String msg = message.getPayload();
      System.out.println("소켓에 메세지 들어왔다~~~!");
      
      //서비스 보내야해서 밖에서 선언함
      String category = null;
      String sender = null;
      String receiver = null;
      String notiMsg = null;
      int bno = 0;
      NotificationVO vo = new NotificationVO();
      
      if(StringUtils.isNotEmpty(msg)) {

         String[] strs = msg.split(",");
         System.out.println("소켓 전송 메세지값: " + Arrays.toString(strs));

         //좋아요
         if(strs != null && strs.length == 6) {
            category = strs[0];
            sender = strs[1]; //글 보는 사람 아이디
            String nick = strs[2]; //글 보는 사람 닉네임
            receiver = strs[3]; //글 쓴 사람 아이디
            String likeChk = strs[4]; //좋아요 눌렀는지 여부
            bno = Integer.parseInt(strs[5]); //좋아요 해당 게시글 번호

            String comment = "";
            if(likeChk.equals("0")) {
               comment = "을 좋아합니다.";
            }

            WebSocketSession targetSession = users.get(receiver);  //메세지 받을 세션 조회
            //실시간 접속시
            if(targetSession != null) {
               //예: 둘리님이 고길동님의 게시물을 좋아합니다.
               TextMessage txtMsg = new TextMessage(nick + "님이 회원님의 게시물" + comment);
               notiMsg = nick + "님이 회원님의 게시물" + comment;
               targetSession.sendMessage(txtMsg); //글 작성자에게 알려줌
               
               vo.setSender(sender);
               vo.setReceiver(receiver);
               vo.setMsg(notiMsg);
               vo.setCategory(category);
               vo.setBno(bno);
               System.out.println("noti VO: " + vo);
               notiService.saveNotification(vo);
            } else { //지금 같은 서버에 혼자 접속중이어서 메세지 들어오는지 확인이 불가능함. 그래서 나한테 보여줘서 체크하는지 확인하는 용도로 썼음.
               //서버에 저장해놨다가 보여주는 방법? 찾아서 현재 로그인 하지 않았더라도 보여줄 수 있는 방법 찾아야한다.
               //else문 주석 처리 해야함
               TextMessage txtMsg = new TextMessage(nick + "님이 회원님의 게시물" + comment);
               notiMsg = nick + "님이 회원님의 게시물" + comment;
               session.sendMessage(txtMsg);
               
               vo.setSender(sender);
               vo.setReceiver(receiver);
               vo.setMsg(notiMsg);
               vo.setCategory(category);
               vo.setBno(bno);
               System.out.println("noti VO: " + vo);
               notiService.saveNotification(vo);
            }
            
         } else if(strs != null && strs.length == 4) { //팔로우
            category = strs[0];
            sender = strs[1]; //댓글 쓴 사람 아이디(댓글), 로그인 한 사람 아이디(팔로우)
            String nick = strs[2];
            receiver = strs[3]; //글 쓴 사람 아이디(댓글), 팔로우 당하는 사람 아이디(팔로우)
            
            WebSocketSession targetSession = users.get(receiver);  //메세지 받을 세션 조회
            
            if(targetSession != null) {
               TextMessage txtMsg = new TextMessage(nick + "님이 회원님을 팔로우 했습니다.");
               notiMsg = nick + "님이 회원님을 팔로우 했습니다.";
               targetSession.sendMessage(txtMsg);
               
               vo.setSender(sender);
               vo.setReceiver(receiver);
               vo.setMsg(notiMsg);
               vo.setCategory(category);
               System.out.println("noti VO: " + vo);
               notiService.saveNotification(vo);
            } else { //메세지 받은 사람이 로그인 안했을 경우(혼자 테스트 해야해서 작성해둠)
               TextMessage txtMsg = new TextMessage(nick + "님이 회원님을 팔로우 했습니다.");
               notiMsg = nick + "님이 회원님을 팔로우 했습니다.";
               session.sendMessage(txtMsg);
               
               vo.setSender(sender);
               vo.setReceiver(receiver);
               vo.setMsg(notiMsg);
               vo.setCategory(category);
               System.out.println("noti VO: " + vo);
               notiService.saveNotification(vo);
            }
            
         } else if(strs != null && strs.length == 5) {
            category = strs[0];
            sender = strs[1]; //댓글 쓴 사람 아이디(댓글)
            String nick = strs[2];
            receiver = strs[3]; //글 쓴 사람 아이디(댓글)
            bno = Integer.parseInt(strs[4]); //해당 게시글 번호
            
            WebSocketSession targetSession = users.get(receiver);  //메세지 받을 세션 조회
            
            if("reply".equals(category)) {
               if(targetSession != null) {
                  TextMessage txtMsg = new TextMessage(nick + "님이 회원님의 게시물에 댓글을 남겼습니다.");
                  notiMsg = nick + "님이 회원님의 게시물에 댓글을 남겼습니다.";
                  targetSession.sendMessage(txtMsg);
                  
                  vo.setSender(sender);
                  vo.setReceiver(receiver);
                  vo.setMsg(notiMsg);
                  vo.setCategory(category);
                  vo.setBno(bno);
                  System.out.println("noti VO: " + vo);
                  notiService.saveNotification(vo);
               } else { //메세지 받은 사람이 로그인 안했을 경우(혼자 테스트 해야해서 작성해둠)
                  TextMessage txtMsg = new TextMessage(nick + "님이 회원님의 게시물에 댓글을 남겼습니다.");
                  notiMsg = nick + "님이 회원님의 게시물에 댓글을 남겼습니다.";
                  session.sendMessage(txtMsg);
                  
                  vo.setSender(sender);
                  vo.setReceiver(receiver);
                  vo.setMsg(notiMsg);
                  vo.setCategory(category);
                  vo.setBno(bno);
                  System.out.println("noti VO: " + vo);
                  notiService.saveNotification(vo);
               }
               
            } 
            
         }

      }
      
   }

   //웹소켓 연결 해제될 때
   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      String senderId = getLoginId(session);
      if(senderId != null) { //로그인 한 경우
         System.out.println("[소켓] 아이디: " + senderId + " 소켓 연결 종료");
         users.remove(senderId);
      }

   }

   //에러 발생 시
   @Override
   public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
      System.out.println("[소켓]익셉션 발생: " + exception.getMessage());

   }

   //로그인한 유저의 http세션을 조회하여 id를 얻는 메서드
   private String getLoginId(WebSocketSession session) {
      Map<String, Object> httpSession = session.getAttributes();
      UserVO loginUser = (UserVO)httpSession.get("loginSession");

      String userId = loginUser.getUserId();

      System.out.println("[소켓]로그인 한 아이디: " + userId);

      return loginUser == null ? null : userId;

   }

}