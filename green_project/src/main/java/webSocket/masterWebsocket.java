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


//웹소켓 주소 설정
@ServerEndpoint("/masterWebsocket")
public class masterWebsocket {
	
	private static Session masterWebsocket=null;
	
	// 웹소켓으로 브라우저가 접속하면 요청되는 함수
	@OnOpen
	public void socketOpen(Session userSession) {
		if(masterWebsocket!=null) {
			try {
				masterWebsocket.close();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		masterWebsocket=userSession;
	}
	
	//웹소켓으로 메세지가 오면 요청되는 함수
	@OnMessage
	public void Message(String message, Session userSession) {
		String[] split=message.split("#",2);
		String key=split[0];
		String msg=split[1];
		
		Websocket.sendMessage(key,msg);
				
	}
	
	//운영자 유저에게 메세지 보내는 함수
	private static void send(String message) {    
		if (masterWebsocket != null) {      
			try {        
				masterWebsocket.getBasicRemote().sendText(message);      
			} catch (IOException e) {        
					e.printStackTrace();      
			}    
		}  
	}
	
	public static void visit(String key) {
		send("{\"status\":\"visit\", \"key\":\""+key+"\"}");
	}
	
	public static void sendMessage(String key, String message) {
		send("{\"status\":\"message\", \"key\":\"" + key + "\", \"message\":\"" + message + "\"}");
	}
	@OnClose
	public void socketClose() {
		masterWebsocket=null;
	}
	
	@OnError
	public void error(Throwable t) {
		t.printStackTrace();
	}
	
}
