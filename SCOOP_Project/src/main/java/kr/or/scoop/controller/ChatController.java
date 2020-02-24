package kr.or.scoop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {
	//채팅방 접속하면 팝업 띄우기
	@RequestMapping("/Chat.do")
	public String showView(String room, Model model) {
		model.addAttribute("room", room);
		
		return "chatting/Chat";
	}
}
