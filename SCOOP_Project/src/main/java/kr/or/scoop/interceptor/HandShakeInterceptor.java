package kr.or.scoop.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

//채팅방 인터셉터
public class HandShakeInterceptor extends HttpSessionHandshakeInterceptor{
	
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
    	ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
    	HttpServletRequest req= ssreq.getServletRequest();
    	String ip = req.getHeader("X-Forwarded-For");
        if (ip == null) ip = req.getRemoteAddr();
    	String cmd  = req.getParameter("cmd");
    	String user  = (String) req.getSession().getAttribute("email");
    	//String user  = ip;
        // 파라미터로 입력된 attributes에 put을 하면 WebSocketSession에서 접근가능
    	attributes.put("cmd", cmd);
    	attributes.put("user", user);
    	System.out.println("handshakeinterceptor"+user);
    	if(cmd.equals("join")) {
    		attributes.put("room", req.getParameter("room"));
    		System.out.println("room handshakeinterceptor"+ip);
    	} 
    	
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
  
    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception ex) {
        super.afterHandshake(request, response, wsHandler, ex);
    }
}
