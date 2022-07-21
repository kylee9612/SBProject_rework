package webSocket;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import controller.DBManager;
import controller.UserDAO;


//웹소켓 주소 설정
@ServerEndpoint("/websocket")
public class Websocket {
	DBManager dbm=new DBManager();
	UserDAO dao=UserDAO.getInstance();
	private static ArrayList<User> sessionUsers = new ArrayList<User>();
	private class User{
		Session session;
		String key;
	}
	//세션으로 접속리스트 탐색
	private static User getUser(Session session) {
		return searchUser(session);
	}
	//키로 접속 리스트에서 유저클래스 탐색
	private static User getUser(String key) {
		return searchUser(key);
	}
	// 접속 리스트 탐색
	private static User searchUser(String key) {
		for(int n=0; n<sessionUsers.size(); n++) {
			if(sessionUsers.get(n).key.equals(key)) {
				return sessionUsers.get(n);
			}
		}
		return null;
	}
	private static User searchUser(Session session) {
		for(int n=0; n<sessionUsers.size(); n++) {
			if(sessionUsers.get(n).session.equals(session)) {
				return sessionUsers.get(n);
			}
		}
		return null;
	}
	// 웹소켓으로 브라우저가 접속하면 요청되는 메서드
	@OnOpen
	public void socketOpen(Session userSession) {
		User user= new User();
		user.key=dao.getLog();
		user.session=userSession;
		sessionUsers.add(user);
		masterWebsocket.visit(user.key);
	}
	
	//웹소켓으로 메세지가 오면 요청되는 메서드
	@OnMessage
	public void Message(String message, Session userSession) {
		User user=getUser(userSession);
		if(user!=null) {
			masterWebsocket.sendMessage(user.key,message);
		}
	}
	
	//웹소켓 접속 끊김
	@OnClose
	public void socketClose(Session userSession) {
		User user=getUser(userSession);
		sessionUsers.remove(user);
	}
	
	@OnError
	public void error(Throwable t) {
		t.printStackTrace();
	}
	
	//유저에게 메시지 보낼 때 사용되는 메소드
	public static void sendMessage(String key,String message) {    
		User user=getUser(key);	
		try {        
				user.session.getBasicRemote().sendText(message);      
				} catch (IOException e) {        
					e.printStackTrace();      
			}    
	}
}
