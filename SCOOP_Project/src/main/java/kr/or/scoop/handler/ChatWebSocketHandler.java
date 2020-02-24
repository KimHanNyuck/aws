package kr.or.scoop.handler;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.scoop.dto.AllNotification;
import kr.or.scoop.dto.ChatRoom;
//socket handler
public class ChatWebSocketHandler extends TextWebSocketHandler {

	// 접속한 전체 유저 관리
	private Map<String, WebSocketSession> users = new ConcurrentHashMap<>();
	// 채팅방 관리
	private Map<String, ChatRoom> roomInfos = new HashMap<>();
	// 접속한 noti user 관리
	private Map<String, WebSocketSession> notiusers = new ConcurrentHashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log(session.getId() + " 연결 됨");
		String cmd = getAttribute(session, "cmd");
		String user = getAttribute(session, "user");
		// 채팅 접속
		Iterator<String> mapiter = users.keySet().iterator();
		while(mapiter.hasNext()) {
			String key = mapiter.next();
			WebSocketSession value = users.get(key);
			System.out.println(key+" : "+value);
		}
		
		if(cmd.equals("on")) {
			users.put(user, session);			
			sendChatRoomInfoMessage(session);
		}
		// 채팅방 접속
		else if(cmd.equals("join")) {
			joinChatRoom(session, user, getAttribute(session, "room"));
		} else if(cmd.equals("all")) {
			System.out.println("요왔다 ..");
		}
	}
	//메시지 수신
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log(session.getId() + "로부터 메시지 수신: " + message.getPayload());
		JSONObject data = new JSONObject(message.getPayload());
		String cmd = data.getString("cmd");

		if (cmd.equals("message")) {
			sendMessage(session, data);
		} else if (cmd.equals("createChatRoom"))
			createChatRoom(session, data);
	}
	//누군가 채팅방 나가면
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String cmd = getAttribute(session, "cmd");
		String user = getAttribute(session, "user");
		// 접속 유저 종료
		if(cmd.equals("on")) { 
			users.remove(user);
		}
		// 채팅창 종료
		else  if(cmd.equals("join")){ 
			String roomName = getAttribute(session, "room");

			ChatRoom room = roomInfos.get(roomName);
			room.removeUser(user);
			sendMemberInfoMessage(room, user + "님이 나가셨습니다.");
			sendChatRoomInfoMessage();
		}
	}
	//예외 발생
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());
	}

	private void log(String logmsg) {
	}
	//메시지 전송
	private void sendMessage(WebSocketSession session, JSONObject data) throws Exception {
		String sendUser = getAttribute(session, "user");
		JSONObject json = new JSONObject().put("message", data.getString("message"))
																.put("sender", sendUser);
		json.put("img", data.getString("img"));
		ChatRoom room = roomInfos.get(data.get("room"));
		for (Map.Entry<String, WebSocketSession> userInfo : room.getUsers().entrySet()) {
			String type = sendUser.equals(userInfo.getKey()) ? "my" : "other";
			json.put("type", type);

			userInfo.getValue().sendMessage(new TextMessage(json.toString()));
		}
	}
	//채팅방 생성
	private void createChatRoom(WebSocketSession session, JSONObject data) throws Exception {
		ChatRoom room = new ChatRoom(data.getString("name")
														, Integer.parseInt(data.getString("max")));

		roomInfos.put(room.getName(), room);
		sendChatRoomInfoMessage();
	}
	//채팅방 참여
	private void joinChatRoom(WebSocketSession session, String user, String room) throws Exception {
		ChatRoom chatRoom = roomInfos.get(room);
		chatRoom.addUser(user, session);
		sendMemberInfoMessage(chatRoom, user + "님이 들어오셨습니다.");

		sendChatRoomInfoMessage();
	}
	//정보 전송
	private void sendMemberInfoMessage(ChatRoom room, String message) throws Exception {
		String jsonString = new JSONObject().put("message", message)
																.put("type", "memberInfo")
																.put("users", new JSONArray(room.getUserName())).toString();

		for (WebSocketSession s : room.getUsers().values())
			s.sendMessage(new TextMessage(jsonString));
	}
	//정보 전송
	private void sendChatRoomInfoMessage() throws Exception {
		JSONArray array = new JSONArray();
		for(ChatRoom room : roomInfos.values()) {
			array.put(new JSONObject().put("max", room.getMax())
													.put("name", room.getName())
													.put("users", new JSONArray(room.getUserName())));
		}
		
		String jsonString = new JSONObject().put("type", "chatRoomInfo")
																.put("rooms", array).toString();
		
		for (WebSocketSession s : users.values())
			s.sendMessage(new TextMessage(jsonString));
	}
	//정보 전송
	private void sendChatRoomInfoMessage(WebSocketSession session) throws Exception {
		JSONArray array = new JSONArray();
		for (ChatRoom room : roomInfos.values()) {
			array.put(new JSONObject().put("max", room.getMax())
					.put("name", room.getName())
					.put("users", new JSONArray(room.getUserName())));
		}

		String jsonString = new JSONObject().put("type", "chatRoomInfo")
																.put("rooms", array).toString();

		session.sendMessage(new TextMessage(jsonString));
	}
	
	public String getAttribute(WebSocketSession session, String parameter) {
		return (String) session.getAttributes().get(parameter);
	}
	
	// 접속 유저 등록
	private void createNoti(WebSocketSession session, JSONObject data) throws Exception {
		AllNotification noti = new AllNotification(data.getString("name"));
		
		sendChatRoomInfoMessage();
	}
}
