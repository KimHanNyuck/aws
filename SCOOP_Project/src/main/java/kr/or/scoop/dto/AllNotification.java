package kr.or.scoop.dto;

import java.util.Map;

import org.springframework.web.socket.WebSocketSession;

public class AllNotification {
	private String name;
	private Map<String, WebSocketSession> users;
	
	
	public AllNotification(String name) {
		super();
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Map<String, WebSocketSession> getUsers() {
		return users;
	}
	public void setUsers(Map<String, WebSocketSession> users) {
		this.users = users;
	}
	@Override
	public String toString() {
		return "AllNotification [name=" + name + ", users=" + users + "]";
	}
	
	

}
