package kr.or.scoop.controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.velocity.exception.VelocityException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.velocity.VelocityEngineFactoryBean;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.LocaleResolver;

import kr.or.scoop.dao.AlarmDao;
import kr.or.scoop.dao.MemberDao;
import kr.or.scoop.dao.MyIssueDao;
import kr.or.scoop.dao.NoticeDao;
import kr.or.scoop.dao.ProjectDao;
import kr.or.scoop.dto.Alarm;
import kr.or.scoop.dto.DoWork;
import kr.or.scoop.dto.FileDrive;
import kr.or.scoop.dto.Member;
import kr.or.scoop.dto.Mention;
import kr.or.scoop.dto.MyIssue;
import kr.or.scoop.dto.PjNotice;
import kr.or.scoop.dto.Reply;
import kr.or.scoop.dto.Role;
import kr.or.scoop.dto.Tissue;
import kr.or.scoop.dto.Tpmember;
import kr.or.scoop.service.MemberService;
import kr.or.scoop.utils.Mail;

@Controller
public class MemberController {
	
	
	@Autowired
	private MemberService service;

	@Autowired
	private SqlSession sqlsession;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private VelocityEngineFactoryBean velocityEngineFactoryBean;

	@Autowired
	private LocaleResolver localeResolver;
	
	// 일반 회원가입 인증
	@RequestMapping(value = "frontpage.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String register(Member member, HttpSession session, Mail mail, HttpServletResponse response) throws ClassNotFoundException, SQLException {
		response.setContentType("text/html; charset=UTF-8");
		int result = 0;
		String viewpage = "";
		session.setAttribute("checkemail", member.getEmail());
		session.setAttribute("checkpwd", this.bCryptPasswordEncoder.encode(member.getPwd()));
		session.setAttribute("checkname", member.getName());
		member.setPwd(this.bCryptPasswordEncoder.encode(member.getPwd()));
		int number = (int) ((Math.random() * 99999) + 100000);
		String temp = String.valueOf(number);
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			Map model = new HashMap();
			model.put("title", "협업공간 SCOOP 회원가입 인증 이메일입니다");
			String mailBody = VelocityEngineUtils.mergeTemplateIntoString(
					velocityEngineFactoryBean.createVelocityEngine(), "emailTemplate.vm", "UTF-8", model);
			messageHelper.setFrom("leeyong1321@gmail.com");
			messageHelper.setTo(member.getEmail());
			messageHelper.setSubject("협업공간 SCOOP 회원가입 인증 이메일입니다");
			messageHelper.setText(mailBody, true);
			mailSender.send(message); //회원가입 인증 메일 보내기
			PrintWriter out = response.getWriter();
			out.println("<script>Swal.fire({" + 
					"							        	    		  title: \"인증 이메일 발송\"," + 
					"							        	    		  text: \"이메일로 인증 이메일을 발송했습니다. 30분 이내에 인증해주세요\"," + 
					"							        	    		  icon: \"info\"," + 
					"							        	    		  button: \"확인\"" + 
					"							        	    		})</script>");
			out.flush(); 
			viewpage = "utils/signUp";
		} catch (Exception e) {
			viewpage = "index";
			PrintWriter out;
			try {
				out = response.getWriter();
				out.println("<script>Swal.fire({\r\n" + 
						"							        	    		  title: \"인증 이메일 발송 중 에러\",\r\n" + 
						"							        	    		  text: \"이메일로 인증 이메일을 발송하던 도중 에러가 발생했습니다 이메일을 확인해주세요\",\r\n" + 
						"							        	    		  icon: \"error\",\r\n" + 
						"							        	    		  button: \"확인\"\r\n" + 
						"							        	    		})</script>");
				out.flush();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
		}
		return viewpage; 

	}

	// 일반 회원가입 인증
	@RequestMapping(value = "registerOk.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String normalInsert(Member member, HttpSession session, HttpServletResponse response) throws ClassNotFoundException, SQLException {
		response.setContentType("text/html; charset=UTF-8");
		int result = 0;
		String viewpage = "";
		member.setPwd((String)session.getAttribute("checkpwd"));
		member.setEmail((String)session.getAttribute("checkemail"));
		member.setName((String)session.getAttribute("checkname"));
		
		int emailcheck = service.idCheck((String)session.getAttribute("checkemail"));
		
		if(emailcheck == 0) {
			result = service.insertMember(member);
		}
		

		if (result > 0) {

			viewpage = "redirect:/index.do";
			session.removeAttribute("checkpwd");
			session.removeAttribute("checkemail");
			session.removeAttribute("checkname");
		} else {
			
			viewpage = "redirect:/index.do";
		}

		return viewpage; // 주의 (website/index.htm

	}

	// 일반회원 로그인
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String login(String email, String pwd, HttpSession session, HttpServletResponse response) {
		MemberDao dao = sqlsession.getMapper(MemberDao.class);
		
		int result = 0;
		String viewpage = "";
		result = service.loginMember(email, pwd);
		if (result > 0) {
			viewpage = "redirect:/userindex.do";
			session.setAttribute("email", email);
			session.setAttribute("kind", "normal");
		} else {
			viewpage = "utils/loginFail";
		}

		return viewpage;
	}

	// 구글회원 로그인
	@RequestMapping(value = "googleLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleLogin(String email, String name, HttpSession session) {

		int result = 0;
		String status = "";
		String viewpage = "";
		MemberDao dao = sqlsession.getMapper(MemberDao.class);
		
		result = service.googleIdCheck(email, name);
		if (result > 0) {
			try {
				int val = dao.getIsAlarm(email);
				if(val == 1) {
					status = "ON";
				}else {
					status = "OFF";
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			
			viewpage = "redirect:/userindex.do";
			session.setAttribute("email", email);
			session.setAttribute("status", status);
			session.setAttribute("kind", "google");
		} else {
			viewpage = "redirect:/index.do";
		}
		
		return viewpage;
	}
	

	// 로그인 성공후 메인페이지 이동
	@RequestMapping(value = "/userindex.do", method = RequestMethod.GET)
	public String userindex(@RequestParam(required = false, name="lang") String language, HttpSession session, 
				HttpServletRequest request, HttpServletResponse response, Model model) {
		
		if(language == null && session.getAttribute("language") != null) {
			language = (String)session.getAttribute("language");
		}else if(language == null) {
			language = "ko";
		}
		
		Locale locale  = new Locale(language);
		localeResolver.setLocale(request, response, locale);
		if(language.equals("ko")) {
			session.setAttribute("defaultlang", "한국어");
		}else{
			session.setAttribute("defaultlang", "English");
		}
		session.setAttribute("language", language);
		String email = "";
		String status = "";
		email = (String)session.getAttribute("email");
		ProjectDao noticeDao = sqlsession.getMapper(ProjectDao.class);
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
		Member member = memberdao.getMember((String)session.getAttribute("email")); //로그인한 사람 정보 불러오기
		Role role = memberdao.getRole(email); //로그인한 사람 등급 불러오기
		String img = memberdao.getProfile(email); //로그인한 사람 프로필사진 불러오기
		try {
		int val = memberdao.getIsAlarm(email);
		System.out.println("val값   " + val);
		if(val == 1) {
			status = "ON";
			session.setAttribute("status", status);
		}else {
			status = "OFF";
			session.setAttribute("status", status);
		}
		} catch(Exception e){
			
		}
		
		int count = 0;	
		List<FileDrive> filedrive = null;
		List<Tissue> mytissuelist = null;
		List<Reply> myreplylist = null;
		List<PjNotice> mypjtlist = null;
		List<Tpmember> pjtlist = null;
		List<Tpmember> tpmemlist =  null;
		try {
			 filedrive = memberdao.getFileDrive(email); //로그인한 사람 파일드라이브 불러오기
			 count = memberdao.getCount(email); //로그인한 사람 프로젝트 갯수 불러오기
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		session.setAttribute("name", member.getName()); //이름 세션저장
		session.setAttribute("img",img); //프로필사진 세션저장
		session.setAttribute("role", role.getRname()); //등급 세션저장
		session.setAttribute("count", count); //협업공간 갯수 세션 저장
		session.setAttribute("filed", filedrive); //파일드라이브 세션 저장
		try {
			pjtlist = noticeDao.getPJT(email); //로그인한사람이 속한 협업공간 불러오기
			tpmemlist = memberdao.getTpmembers(member.getEmail()); //로그인한 사람이 속한 협업공간의 멤버목록 불러오기
			mytissuelist = myissuedao.teamWriteTiisueList(member.getIdtime(), email); //새로운 이슈목록 불러오기
			myreplylist = myissuedao.teamWriteReplyList(member.getIdtime()); //새로운 댓글목록 불러오기
			mypjtlist = myissuedao.teamWriteNoticeList(member.getEmail(), member.getIdtime()); //새로운 공지사항목록 불러오기
			model.addAttribute("mytissuelist",mytissuelist);
			model.addAttribute("myreplylist",myreplylist);
			model.addAttribute("mypjtlist",mypjtlist);
		} catch (Exception e) {
			// TODO: handle exception
		}
		if(pjtlist!=null) {
			
			session.setAttribute("pjtlist", pjtlist);
			session.setAttribute("tpmemlist", tpmemlist);
			List<Tissue> myNewTissueList = myissuedao.teamWriteTiisueList(member.getIdtime(), email); //새로운 이슈목록 불러오기
			
			model.addAttribute("mypjtlist", pjtlist);
			model.addAttribute("myNewTissueList", myNewTissueList);
		}
		return "user/dashBoard";
	}
	
	//새로운 댓글 목록 불러오기
	@RequestMapping(value = "/newReply.do", method = RequestMethod.GET)
	public String userindexReply(@RequestParam(required = false, name="lang") String language, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response, Model model) {
		if(language == null) {
			language = "ko";
		}
		Locale locale  = new Locale(language);
		localeResolver.setLocale(request, response, locale);
		if(language.equals("ko")) {
			session.setAttribute("defaultlang", "한국어");
		}else{
			session.setAttribute("defaultlang", "English");
		}
		String email = "";
		
		email = (String)session.getAttribute("email");
		ProjectDao noticeDao = sqlsession.getMapper(ProjectDao.class);
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
		Member member = memberdao.getMember((String)session.getAttribute("email"));
		Role role = memberdao.getRole(email);
		String img = memberdao.getProfile(email);
		int count = 0;	
		List<FileDrive> filedrive = null;
		List<Tissue> mytissuelist = null;
		List<Reply> myreplylist = null;
		List<PjNotice> mypjtlist = null;
		List<Tpmember> pjtlist = null;
		List<Tpmember> tpmemlist =  null;
		try {
			filedrive = memberdao.getFileDrive(email);
			count = memberdao.getCount(email);
		} catch (Exception e) {
			// TODO: handle exception
		}
		session.setAttribute("name", member.getName());
		session.setAttribute("img",img); 
		session.setAttribute("role", role.getRname());
		session.setAttribute("count", count);
		session.setAttribute("filed", filedrive);
		try {
			pjtlist = noticeDao.getPJT(email);
			tpmemlist = memberdao.getTpmembers(member.getEmail());
			mytissuelist = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
			myreplylist = myissuedao.teamWriteReplyList(member.getIdtime());
			mypjtlist = myissuedao.teamWriteNoticeList(member.getEmail(), member.getIdtime());
			model.addAttribute("mytissuelist",mytissuelist);
			model.addAttribute("myreplylist",myreplylist);
			model.addAttribute("mypjtlist",mypjtlist);
		} catch (Exception e) {
			// TODO: handle exception
		}
		if(pjtlist!=null) {
			session.setAttribute("pjtlist", pjtlist);
			session.setAttribute("tpmemlist", tpmemlist);
			List<Tissue> myNewTissueList = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
			List<PjNotice> myNewPjNoticeList = myissuedao.teamWriteNoticeList(email, member.getIdtime());
			List<Reply> myNewReplyList = myissuedao.teamWriteReplyList(member.getIdtime());
			model.addAttribute("mypjtlist", pjtlist);
			model.addAttribute("myNewTissueList", myNewTissueList);
			model.addAttribute("mypjtlist", pjtlist);
			model.addAttribute("myNewPjNoticeList", myNewPjNoticeList);
			model.addAttribute("myNewTissueList", myNewTissueList);
			model.addAttribute("myNewReplyList", myNewReplyList);
		}
		return "user/dashBoard-reply";
		
	}
	//새로운 공지사항 목록 불러오기
	@RequestMapping(value = "/newNotice.do", method = RequestMethod.GET)
	public String userindexNotice(@RequestParam(required = false, name="lang") String language, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response, Model model) {
		if(language == null) {
			language = "ko";
		}
		Locale locale  = new Locale(language);
		localeResolver.setLocale(request, response, locale);
		if(language.equals("ko")) {
			session.setAttribute("defaultlang", "한국어");
		}else{
			session.setAttribute("defaultlang", "English");
		}
		String email = "";
		email = (String)session.getAttribute("email");
		ProjectDao noticeDao = sqlsession.getMapper(ProjectDao.class);
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
		Member member = memberdao.getMember((String)session.getAttribute("email"));
		Role role = memberdao.getRole(email);
		String img = memberdao.getProfile(email);
		int count = 0;	
		List<FileDrive> filedrive = null;
		List<Tissue> mytissuelist = null;
		List<PjNotice> mypjtlist = null;
		List<Tpmember> pjtlist = null;
		List<Tpmember> tpmemlist =  null;
		try {
			filedrive = memberdao.getFileDrive(email);
			count = memberdao.getCount(email);
		} catch (Exception e) {
			// TODO: handle exception
		}
		session.setAttribute("name", member.getName());
		session.setAttribute("img",img); 
		session.setAttribute("role", role.getRname());
		session.setAttribute("count", count);
		session.setAttribute("filed", filedrive);
		try {
			pjtlist = noticeDao.getPJT(email);
			tpmemlist = memberdao.getTpmembers(member.getEmail());
			mytissuelist = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
			mypjtlist = myissuedao.teamWriteNoticeList(member.getEmail(), member.getIdtime());
			model.addAttribute("mytissuelist",mytissuelist);
			model.addAttribute("mypjtlist",mypjtlist);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			// TODO: handle exception
		}
		if(pjtlist!=null) {
			session.setAttribute("pjtlist", pjtlist);
			session.setAttribute("tpmemlist", tpmemlist);
			List<Tissue> myNewTissueList = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
			List<PjNotice> myNewPjNoticeList = myissuedao.teamWriteNoticeList(email, member.getIdtime());
			List<Reply> myNewReplyList = myissuedao.teamWriteReplyList(member.getIdtime());
			model.addAttribute("mypjtlist", pjtlist);
			model.addAttribute("myNewTissueList", myNewTissueList);
			model.addAttribute("mypjtlist", pjtlist);
			model.addAttribute("myNewPjNoticeList", myNewPjNoticeList);
			model.addAttribute("myNewTissueList", myNewTissueList);
			model.addAttribute("myNewReplyList", myNewReplyList);
		}
		return "user/dashBoard-notice";
	}
	//멘션 목록 불러오기
	@RequestMapping(value = "/mention.do", method = RequestMethod.GET)
	public String mention(@RequestParam(required = false, name="lang") String language, HttpSession session, 
				HttpServletRequest request, HttpServletResponse response, Model model) {
		if(language == null) {
			language = "ko";
		}
		Locale locale  = new Locale(language);
		localeResolver.setLocale(request, response, locale);
		if(language.equals("ko")) {
			session.setAttribute("defaultlang", "한국어");
		}else{
			session.setAttribute("defaultlang", "English");
		}
		String email = "";
		
		email = (String)session.getAttribute("email");
		ProjectDao noticeDao = sqlsession.getMapper(ProjectDao.class);
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
		Member member = memberdao.getMember((String)session.getAttribute("email"));
		Role role = memberdao.getRole(email);
		String img = memberdao.getProfile(email);
		int count = 0;	
		List<FileDrive> filedrive = null;
		List<Tissue> mytissuelist = null;
		List<Reply> myreplylist = null;
		List<PjNotice> mypjtlist = null;
		List<Tpmember> pjtlist = null;
		List<Tpmember> tpmemlist =  null;
		List<Tissue> myNewTissueList = null;
		List<Mention> mentions = null;
		try {
			 filedrive = memberdao.getFileDrive(email);
			 count = memberdao.getCount(email);
		} catch (Exception e) {
			// TODO: handle exception
		}
		session.setAttribute("name", member.getName());
		session.setAttribute("img",img); 
		session.setAttribute("role", role.getRname());
		session.setAttribute("count", count);
		session.setAttribute("filed", filedrive);
		try {
			pjtlist = noticeDao.getPJT(email);
			tpmemlist = memberdao.getTpmembers(member.getEmail());
			mytissuelist = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
			myreplylist = myissuedao.teamWriteReplyList(member.getIdtime());
			mypjtlist = myissuedao.teamWriteNoticeList(member.getEmail(), member.getIdtime());
			model.addAttribute("mytissuelist",mytissuelist);
			model.addAttribute("myreplylist",myreplylist);
			model.addAttribute("mypjtlist",mypjtlist);
		} catch (Exception e) {
			// TODO: handle exception
		}
		if(pjtlist!=null) {
			session.setAttribute("pjtlist", pjtlist);
			session.setAttribute("tpmemlist", tpmemlist);
			myNewTissueList = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
			mentions = memberdao.getMention(member.getEmail());
			model.addAttribute("mypjtlist", pjtlist);
			model.addAttribute("myNewTissueList", myNewTissueList);
			model.addAttribute("mentions",mentions);
		}
		return "user/dashBoard-mention";
	}
	//할일 목록 불러오기
	@RequestMapping(value = "/dowork.do", method = RequestMethod.GET)
	public String dowork(@RequestParam(required = false, name="lang") String language, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response, Model model) {
		if(language == null) {
			language = "ko";
		}
		Locale locale  = new Locale(language);
		localeResolver.setLocale(request, response, locale);
		if(language.equals("ko")) {
			session.setAttribute("defaultlang", "한국어");
		}else{
			session.setAttribute("defaultlang", "English");
		}
		String email = "";
		
		email = (String)session.getAttribute("email");
		ProjectDao noticeDao = sqlsession.getMapper(ProjectDao.class);
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
		Member member = memberdao.getMember((String)session.getAttribute("email"));
		Role role = memberdao.getRole(email);
		String img = memberdao.getProfile(email);
		int count = 0;	
		List<FileDrive> filedrive = null;
		List<Tissue> mytissuelist = null;
		List<Reply> myreplylist = null;
		List<PjNotice> mypjtlist = null;
		List<Tpmember> pjtlist = null;
		List<Tpmember> tpmemlist =  null;
		List<Tissue> myNewTissueList = null;
		List<Mention> mentions = null;
		List<DoWork> doworks = null;
		try {
			filedrive = memberdao.getFileDrive(email);
			count = memberdao.getCount(email);
		} catch (Exception e) {
			// TODO: handle exception
		}
		session.setAttribute("name", member.getName());
		session.setAttribute("img",img); 
		session.setAttribute("role", role.getRname());
		session.setAttribute("count", count);
		session.setAttribute("filed", filedrive);
		try {
			pjtlist = noticeDao.getPJT(email);
			tpmemlist = memberdao.getTpmembers(member.getEmail());
			mytissuelist = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
			myreplylist = myissuedao.teamWriteReplyList(member.getIdtime());
			mypjtlist = myissuedao.teamWriteNoticeList(member.getEmail(), member.getIdtime());
			doworks = myissuedao.teamWriteDoworkList(member.getEmail());
			model.addAttribute("mytissuelist",mytissuelist);
			model.addAttribute("myreplylist",myreplylist);
			model.addAttribute("mypjtlist",mypjtlist);
			model.addAttribute("doworks", doworks);
		} catch (Exception e) {
			// TODO: handle exception
		}
		if(pjtlist!=null) {
			session.setAttribute("pjtlist", pjtlist);
			session.setAttribute("tpmemlist", tpmemlist);
			myNewTissueList = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
			mentions = memberdao.getMention(member.getEmail());
			model.addAttribute("mypjtlist", pjtlist);
			model.addAttribute("myNewTissueList", myNewTissueList);
			model.addAttribute("mentions",mentions);
		}
		return "user/dashBoard-doWork";
	}
	// 로그아웃
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session, HttpServletResponse response) {
		String viewpage = "";
		viewpage = "redirect:/index.do";
		session.invalidate();
		return viewpage;

	}

	// 네이버회원 로그인
	@RequestMapping(value = "naverLogin.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String naverLogin(String email, String name, HttpSession session) {

		int result = 0;
		String viewpage = "";
		String status = "";
		MemberDao dao = sqlsession.getMapper(MemberDao.class);
		
		result = service.naverIdCheck(email, name);
		if (result > 0) {
			int val = dao.getIsAlarm(email);
			if(val == 1) {
				status = "ON";
			}else {
				status = "OFF";
			}
			viewpage = "redirect:/naverCertified.do";
			session.setAttribute("email", email);
			session.setAttribute("status", status);
			session.setAttribute("kind", "naver");
		} else {
			viewpage = "redirect:/userindex.do";
		}

		return viewpage;
	}

	// 비밀번호 찾기 메일 발송
	@RequestMapping(value="/forgotpwd.do")
	@ResponseBody
	public String forgotPwd(Mail mail, HttpServletRequest request, HttpServletResponse response, HttpSession session, String email) {
		response.setContentType("text/html; charset=UTF-8");
		session.setAttribute("email", email);
		
		String viewpage = "";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			Map model = new HashMap();
			model.put("title", "협업공간 SCOOP 본인 인증 이메일입니다");
			// model.put("password", temp);
			String mailBody = VelocityEngineUtils.mergeTemplateIntoString(velocityEngineFactoryBean.createVelocityEngine(), "forgotPwd.vm", "UTF-8", model);
			messageHelper.setFrom("leeyong1321@gmail.com");
			messageHelper.setTo(email);
			messageHelper.setSubject("회원님의 SCOOP 계정의 본인 인증 이메일입니다");
			messageHelper.setText(mailBody, true);
			mailSender.send(message);
			
			viewpage = "index";
			
		} catch (Exception e1) {
			e1.printStackTrace();
			try {
			viewpage = "index";
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return viewpage;
	}
	
	// 이메일 인증 확인
	@RequestMapping(value="/emailCertified.do")
	public String emailCertified() {
		return "certified/emailCertified";
	}
	
	// 비밀번효 변경 페이지
	@RequestMapping(value="/changePwd.do")
	public String ChangePwd() {
		return "user/forgotPwd";
	}
	
	// 비밀번호 변경 완료
	@RequestMapping("changePwdOk.do")
	public String changePwdOk(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String pwd = this.bCryptPasswordEncoder.encode(request.getParameter("pwd"));
		String email = (String)session.getAttribute("email");
		
		
		MemberDao dao = sqlsession.getMapper(MemberDao.class);
		int result = dao.changePassword(pwd, email);
		
		String viewpage = "";
		if(result > 0) {
			viewpage = "utils/pwdOk";
		}else {
			viewpage = "utils/pwdFail";
		}
		
		session.removeAttribute("email");
		
		return viewpage;
	}
	
	// 회원가입 인증
	@RequestMapping(value = "/certified.do")
	public String certified() {
		return "certified/Certified";
	}
	//협업공간에 멤버 초대 메일 발송하기
	@RequestMapping(value = "inviteTeam.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inviteTeam(HttpServletRequest request, HttpSession session) throws MessagingException, VelocityException, IOException {
		try {
			ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
			String mailFrom = (String)session.getAttribute("email");
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
			request.setCharacterEncoding("UTF-8");
			String tseq = request.getParameter("tseq");
			int cnt = Integer.parseInt(request.getParameter("invitecnt"));
			String[] invitemem = new String[cnt];
			for(int i=0;i<cnt;i++) {
				invitemem[i] = request.getParameter("email"+i);
				int rank = dao.searchRank(Integer.parseInt(tseq), invitemem[i]);
				if(rank>0) {
					return "utils/emailSwal";
				}
			}
			for(int i=0;i<cnt;i++) {
				if(request.getParameter("email"+i)!=null) {
					invitemem[i] = request.getParameter("email"+i);
					messageHelper.setFrom("leeyong1321@gmail.com");
					messageHelper.setTo(invitemem[i]);
					messageHelper.setSubject("협업공간 SCOOP 팀 멤버 초대 인증 이메일입니다");
					Map model = new HashMap();
					model.put("mailTo", invitemem[i]);
					model.put("mailFrom", mailFrom);
					model.put("tseq", tseq);
					String mailBody = VelocityEngineUtils.mergeTemplateIntoString(velocityEngineFactoryBean.createVelocityEngine(), "invite_email.vm","UTF-8", model);
					messageHelper.setText(mailBody,true);
					mailSender.send(message);
				}
			}
			
		} catch (Exception e) {
			String mailFrom = (String)session.getAttribute("email");
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
			request.setCharacterEncoding("UTF-8");
			String tseq = request.getParameter("tseq");
			int cnt = Integer.parseInt(request.getParameter("invitecnt"));
			String[] invitemem = new String[cnt];
			for(int i=0;i<cnt;i++) {
				if(request.getParameter("email"+i)!=null) {
					invitemem[i] = request.getParameter("email"+i);
					messageHelper.setFrom("leeyong1321@gmail.com");
					messageHelper.setTo(invitemem[i]);
					messageHelper.setSubject("협업공간 SCOOP 팀 멤버 초대 인증 이메일입니다");
					Map model = new HashMap();
					model.put("mailTo", invitemem[i]);
					model.put("mailFrom", mailFrom);
					model.put("tseq", tseq);
					String mailBody = VelocityEngineUtils.mergeTemplateIntoString(velocityEngineFactoryBean.createVelocityEngine(), "invite_email.vm","UTF-8", model);
					messageHelper.setText(mailBody,true);
					mailSender.send(message);
				}
			}
			
		} 
		return "utils/emailSwalOk";
	}
	
	//회원정보수정 페이지 이동
	@RequestMapping(value="memberEdit.do" , method = RequestMethod.GET)
	public String EditProfile(Model model,HttpSession session) {
		MemberDao dao = sqlsession.getMapper(MemberDao.class);
		Member member = dao.getMember((String)session.getAttribute("email"));
		
		String pwd = this.bCryptPasswordEncoder.encode(member.getPwd());
		
		model.addAttribute("member",member);
		model.addAttribute("pass",pwd);
		session.setAttribute("img", member.getProfile());
		
		return "user/app-profile";
		
	}
	
	//회원정보 수정
	@RequestMapping(value="editCheck.do" , method = RequestMethod.POST)
	public String UpdateProfile(Member member,HttpServletRequest request,HttpSession session) {
		    
				
			CommonsMultipartFile multifile = member.getFilesrc();
			String filename = multifile.getOriginalFilename();
			if(filename.equals("")) {
				member.setProfile((String)session.getAttribute("img"));
			}else {
				member.setProfile(filename);
			}
			String path = request.getServletContext().getRealPath("/user/upload");
			
			String fpath = path + "\\"+ filename; 
				
				if(!filename.equals("")) { //실 파일 업로드
					FileOutputStream fs = null;
					try {
						fs = new FileOutputStream(fpath);
					} catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						
					}finally {
						try {
							fs.write(multifile.getBytes());
							fs.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
			
		   MemberDao dao = sqlsession.getMapper(MemberDao.class);
		if(member.getPwd().equals("")) {
			Member checkmember = dao.getMember((String)session.getAttribute("email"));
			member.setPwd(checkmember.getPwd());
			dao.updateMember(member);
		} else {
			member.setPwd(this.bCryptPasswordEncoder.encode(member.getPwd()));
			dao.updateMember(member);
		}
		return "redirect:/userindex.do";
	}
	
	// 결재페이지
	@RequestMapping(value = "/paymentPage.do")
	public String paymentPage() {
		return "user/Payment";
	}
	
	//알림 페이지 
	@RequestMapping(value="app-alram.do", method=RequestMethod.GET)
	public String alarmpage() {
		return "user/app-alram";
	}
	
	//회원 등급 수정
	@RequestMapping(value="updateRole.do", method=RequestMethod.POST)
	public String updateRole(HttpSession session) {
		int result = 0;
		String viewpage;
		result = service.updateRole((String)session.getAttribute("email"));
		if(result > 0) {
			viewpage = "redirect:/paymentPage.do";
		}else {
			viewpage = "user/userindex";
		}
		return viewpage;
		
	}
	
	// 네이버이메일 인증 확인
	@RequestMapping(value = "/naverCertified.do")
	public String naverCertified() {
		return "utils/naverCertified";
	}
	
	// 아이디 중복 확인
	@RequestMapping(value = "/idOverlab.do")
	@ResponseBody
	public int emailCheck(String email) {
		int result = 0;
		MemberDao dao = sqlsession.getMapper(MemberDao.class);
		result = dao.idCheck(email);
		return result;
	}
	
	// 새로운 팀이슈
		@RequestMapping(value = "newTissue.do", method = RequestMethod.GET)
		public String newTissue(HttpSession session, Model model) {
			String viewpage = "";
			String email = (String)session.getAttribute("email");
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
			ProjectDao projectdao = sqlsession.getMapper(ProjectDao.class);
			try {
				Member member = memberdao.getMember(email);
				List<Tpmember> pjtlist = projectdao.getPJT(email);
				List<Tissue> myNewTissueList = myissuedao.teamWriteTiisueList(member.getIdtime(), email);
				model.addAttribute("mypjtlist", pjtlist);
				model.addAttribute("myNewTissueList", myNewTissueList);
				viewpage = "user/UserNewTissue";
			} catch (Exception e) {
				// TODO: handle exception
				viewpage = "redirect:/userindex.do";
			}
			
			return viewpage;
		}
		
		
		// 캘린더 이슈 추가
		@RequestMapping(value = "/addCalendarAjax.do")
		public String addCalendarAjax() {
			return "utils/addCalendarAjax";
		}
		// 팀장이 멤버 탈퇴시키기
		@RequestMapping(value="memberDelete.do", method = {RequestMethod.POST, RequestMethod.GET})
		public String memberDelete(HttpSession session) {
		String email = (String)session.getAttribute("email");
		String viewpage;
		int result = 0;
		result = service.deleteMember(email);
		
		if(result > 0) {
			viewpage = "index";
		}else {
			viewpage = "user/userindex";
		}
		return viewpage;	
		}
		
		// 알람 설정 
		@RequestMapping(value="updateAlarm.do" , method = RequestMethod.POST)
		public String updateAlarm(HttpSession session,Model model,String status) {
			System.out.println("들어옴?");
			System.out.println("들어옴? " + status);
			String viewpage;
			int val = 0;
			int result = 0;
			String email = (String)session.getAttribute("email");
			MemberDao dao = sqlsession.getMapper(MemberDao.class);
			if(status.equals("off")) {
				val = dao.updateAlarmTrue(email);
				viewpage = "commons/headerAndLeft";
			}else {
				val = dao.updateAlarmFalse(email);
				viewpage = "commons/headerAndLeft";
			}
			
			return viewpage;
		}
	
}
