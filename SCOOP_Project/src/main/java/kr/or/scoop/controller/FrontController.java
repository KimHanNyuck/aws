package kr.or.scoop.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.LocaleResolver;

@Controller
public class FrontController {

	@Autowired
	private LocaleResolver localeResolver;
	
	//메인 페이지
	@RequestMapping("/index.do")
	public String change(@RequestParam(required = false, name="lang") String language, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		//언어 선택(변경)
		if(language == null && session.getAttribute("language") != null) {
			language = (String)session.getAttribute("language");
		}else if(language == null) {
			language = "ko";
		}
		
		Locale locale  = new Locale(language);
		localeResolver.setLocale(request, response, locale);
		session.setAttribute("language", language);
		return "index";
	}
	@RequestMapping("/successPwd.do")
	public String successPwd() {
		
		return "utils/forgotPwd";
	}
	
}
