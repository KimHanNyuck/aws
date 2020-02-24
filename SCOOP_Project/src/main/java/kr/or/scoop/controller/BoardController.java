package kr.or.scoop.controller;

import java.io.FileOutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.scoop.dao.MemberDao;
import kr.or.scoop.dao.MyIssueDao;
import kr.or.scoop.dao.NoticeDao;
import kr.or.scoop.dao.ProjectDao;
import kr.or.scoop.dao.TissueDao;
import kr.or.scoop.dto.DoWork;
import kr.or.scoop.dto.FileDrive;
import kr.or.scoop.dto.GoogleDrive;
import kr.or.scoop.dto.Mention;
import kr.or.scoop.dto.MyIssue;
import kr.or.scoop.dto.Notice;
import kr.or.scoop.dto.PjNotice;
import kr.or.scoop.dto.ProjectMemberlist;
import kr.or.scoop.dto.Reply;
import kr.or.scoop.dto.Role;
import kr.or.scoop.dto.TeamPjt;
import kr.or.scoop.dto.Tissue;
import kr.or.scoop.service.BoardService;
import kr.or.scoop.service.PrivateService;
import kr.or.scoop.service.TeamService;
import net.sf.json.JSONArray;

@Controller
public class BoardController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private TeamService tservice;
	@Autowired
	private PrivateService privateservice;
	
	// 내가 작성한 이슈불러오기
	@RequestMapping(value = "/myissue.do", method = RequestMethod.GET)
	public String myissue(HttpSession session, Model model) {
		String email = "";
		email = (String)session.getAttribute("email"); //로그인한 사람 이메일
		MyIssueDao dao = sqlSession.getMapper(MyIssueDao.class);
		List<MyIssue> ti = dao.MyWriteTiisueList(email); //내가작성한 협업공간 이슈 리스트
		List<MyIssue> pi = dao.MyWriteIssueList(email); //내가 작성한 프라이빗 이슈 리스트
		model.addAttribute("pi",pi);
		model.addAttribute("ti",ti);
		return "issue/myissue";
	}
	// 내가 작성한 이슈 댓글리스트 불러오기
	@RequestMapping(value = "/myissueReply.do", method = RequestMethod.GET)
	public String myissueReply(HttpSession session, Model model) {
		String email = "";
		email = (String)session.getAttribute("email");//로그인한 사람 이메일
		MyIssueDao dao = sqlSession.getMapper(MyIssueDao.class);
		List<Reply> reply = dao.MyWriteReplyList(email); //내가 작성한 댓글 불러오기
		model.addAttribute("re",reply);
		return "issue/myissueReply";
	}
	
	// 프라이빗이슈디테일 불러오기 
	@RequestMapping(value = "/myissueDetail.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String myissueDetail(int piseq, Model model) {
		
		MyIssueDao dao = sqlSession.getMapper(MyIssueDao.class);
		MyIssue myissue = dao.myissueDetail(piseq);
		List<Mention> mentions = dao.getMyMentions(piseq); //멘션리스트 불러오기
		List<GoogleDrive> googledrive = dao.getMyGoogleDrive(piseq); //구글드라이브 리스트 불러오기
		List<DoWork> dowork = dao.getMyDoWork(piseq); //할일 리스트 불러오기
		List<FileDrive> files = dao.getMyFiles(piseq); //파일 리스트 불러오기
		model.addAttribute("myissue", myissue);
		model.addAttribute("mymention", mentions);
		model.addAttribute("mygdrive", googledrive);
		model.addAttribute("mydowork", dowork);
		model.addAttribute("files", files);
		return "issue/myissueDetail";
	}
	
	// 협업공간 이슈디테일 
	@RequestMapping(value="/teamissueDetail.do",method = {RequestMethod.POST,RequestMethod.GET})
	public String teamissueDetail(int tiseq, Model model, HttpSession session){
		TissueDao dao = sqlSession.getMapper(TissueDao.class);
		MemberDao mdao = sqlSession.getMapper(MemberDao.class);
		Tissue tissue = dao.teamissueDetail(tiseq);
		List<Reply> reply = dao.teamCommentOk(tiseq); //댓글 리스트 불러오기 
		List<Mention> mentions = dao.getMentions(tiseq); // 멘션 리스트 불러오기
		List<GoogleDrive> googledrive = dao.getGoogleDrive(tiseq); //구글드라이브 리스트 불러오기
		List<DoWork> dowork = dao.getDoWork(tiseq); // 할일 리스트 불러오기
		try {
			String email = (String)session.getAttribute("email");
			List<FileDrive> filedrive = mdao.getFileDrive(email); //로그인한 사람 파일드라이브 불러오기
			session.setAttribute("filed", filedrive); //파일드라이브 세션 저장
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println(tiseq);
		List<FileDrive> files = dao.getFiles(tiseq); // 파일 드라이브 리스트 불러오기
		model.addAttribute("tissue", tissue);
		model.addAttribute("reply",reply);
		model.addAttribute("mentions",mentions);
		model.addAttribute("gdrive", googledrive);
		model.addAttribute("dowork", dowork);
		model.addAttribute("files", files);
		return "issue/teamissueDetail";
	}
	//전체 공지사항 불러오기
	@RequestMapping(value="notice.do" , method = RequestMethod.GET)
	public String noticeJoin(Notice notice, Model model) {
		NoticeDao dao = sqlSession.getMapper(NoticeDao.class);
		List<Notice> n = dao.getNotice();
		for(int i=0; i<n.size();i++) {
			n.get(i).setBncontent(n.get(i).getBncontent().replace("<br>", " ")); //<br>을 띄어쓰기로 치환해서 보여줌
		}
		model.addAttribute("notice",n);
		return "issue/notice";
	}
	//공지사항 글쓰기
	@RequestMapping(value="noticeWrite.do" , method=RequestMethod.POST)
	public String noticeWrite(Notice notice) {
		int result = 0;
		String viewpage;
		notice.setBncontent(notice.getBncontent().replace("\r\n", "<br>"));
		result = service.insertNotice(notice);//공지사항 작성
		
		if(result > 0) {
			viewpage = "redirect:/notice.do";
		}else {
			viewpage = "user/userindex";
		}
		
		return viewpage;
	
	}
	//공지사항 디테일 불러오기
	@RequestMapping(value="noticeDetail.do" , method=RequestMethod.GET)	
	public String noticeDetail(int bnseq,Model model) {
		NoticeDao dao = sqlSession.getMapper(NoticeDao.class);
		Notice notice = dao.detailNotice(bnseq); //공지사항 디테일
		model.addAttribute("notice",notice);
		
		return "issue/noticeDetail";
	}
	
	// 개인 이슈 북마크
	@RequestMapping(value="/pibookmark.do", method=RequestMethod.POST)
	public String piBookMark(HttpSession session, int piseq, String status, Model model) {
		String email = (String)session.getAttribute("email");
		String viewpage = "";
		MyIssueDao dao = sqlSession.getMapper(MyIssueDao.class);
		int result = 0;
		
		
		// 북마크 추가, 제거
		if(status.equals("bookoff")) {
			result = dao.addPBookMark(piseq, email); 
		}else if(status.equals("bookon")) {
			result = dao.delPBookMark(piseq, email);
		}
		
		
		// 북마크 추가, 제거 성공시 북마크 상태 변경
		if(status.equals("bookoff") && result > 0) {
			status = "bookon";
			viewpage = "redirect:private.do";
		}else if(status.equals("bookon") && result > 0) {
			status = "bookoff";
			viewpage = "redirect:private.do";
		}
		
		model.addAttribute("status", status);
		
		
		return viewpage;
	}
	// 팀이슈 북마크
	@RequestMapping(value="/tibookmark.do", method = RequestMethod.POST)
	public String tiBookMark (HttpSession session, int tseq, int tiseq, String status, Model model) {
		String email = (String)session.getAttribute("email");
		String viewpage = "";
		int result = 0;
		TissueDao dao = sqlSession.getMapper(TissueDao.class);
		
		// 북마크 추가/제거
		if(status.equals("bookoff")) {
			result = dao.addTBookMark(tiseq, email);
		}else if(status.equals("bookon")) {
			result = dao.delTBookMark(tiseq, email);
		}
		
		// 북마크 추가, 제거 성공시 북마크 상태 변경
		if(status.equals("bookoff") && result > 0) {
			status = "bookon";
			viewpage = "redirect:projectDetail.do?tseq="+tseq;
		}else if(status.equals("bookon") && result > 0) {
			status = "bookoff";
			viewpage = "redirect:projectDetail.do?tseq="+tseq;
		}
		
		model.addAttribute("status", status);
		
		return viewpage;
	}
	//북마크 삭제하기
	@RequestMapping("delbook.do")
	public String delBookMark(HttpSession session, int piseq, int tiseq) {
		String email = (String)session.getAttribute("email");
		String viewpage = "";
		int result = 0;
		
		MyIssueDao pidao = sqlSession.getMapper(MyIssueDao.class);
		TissueDao tidao = sqlSession.getMapper(TissueDao.class);
		
		// 팀이슈, 개인이슈 판별후 삭제 
		if(tiseq > 0) {
			result = tidao.delTBookMark(tiseq, email);
		}else if(piseq > 0) {
			result = pidao.delPBookMark(piseq, email);
		}
		viewpage = "redirect:bookmark.do";
		
		return viewpage;
	}
	//공지사항 수정불러오기
	@RequestMapping(value="noticeEdit.do" , method=RequestMethod.GET)
	public String noticeUpdate(int bnseq,Notice notice,Model model) {
		String viewpage = "";
		NoticeDao dao = sqlSession.getMapper(NoticeDao.class);
		Notice n = dao.detailNotice(bnseq);
		n.setBncontent(n.getBncontent().replace("<br>", "\n"));
		model.addAttribute("n",n);
				
	viewpage = "issue/noticeEdit";
		
			
		return viewpage;
	}
	//공지사항 수정하기
	@RequestMapping(value="noticeEditOk.do" , method=RequestMethod.POST)
	public String noticeUpdateCheck(int bnseq,Notice notice,Model model) {
		int result = 0;
		String viewpage = "";
		notice.setBncontent(notice.getBncontent().replace("\r\n", "<br>"));
		result = service.updateNotice(notice);
		if(result > 0) {
			model.addAttribute("notice",notice);
			viewpage = "redirect:/notice.do";
			
		}else {
			viewpage = "issue/notice";
		}
			
		return viewpage;
	}
	//모든 이슈 키워드 검색하기
	@RequestMapping(value="searchIssue.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String searchIssue(String email,String word,Model model) {
		int result = 0;
		String viewpage = "";
		NoticeDao dao = sqlSession.getMapper(NoticeDao.class);
		List<MyIssue> teamIssue = dao.searchTeamIssue(email, word);
		List<MyIssue> myIssue = dao.searchMyIssue(email, word);
		model.addAttribute("teamIssue", teamIssue);
		model.addAttribute("myIssue", myIssue);
		if(result > 0) {
			viewpage = "issue/searchIssue";
			
		}else {
			viewpage = "issue/searchIssue";
		}
		
		
		return viewpage;
	}
	
	//팀이슈 댓글 비동기
	@RequestMapping(value = "teamComment.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String teamCommentAjax(int tiseq,String rcontent,String email,Model model) {
		int result = 0;	
		String viewpage = "";
		result = tservice.teamComment(tiseq, rcontent, email);
		
		if(result > 0) {
			model.addAttribute("ajax","댓글 성공");
			viewpage = "utils/ajax";
			
		}else {
			model.addAttribute("ajax","댓글 실패");
			viewpage = "utils/ajax";
		}
		return viewpage;
	}
	//팀이슈 댓글 비동기 뿌리기
	@RequestMapping(value = "teamCommentOk.do",method = {RequestMethod.POST,RequestMethod.GET})
	public String teamCommentOk(int tiseq,Model model) {
		String viewpage = "utils/ajax";
		List<Reply> reply = tservice.teamCommentOk(tiseq);
		JSONArray jsonlist = JSONArray.fromObject(reply);
		model.addAttribute("ajax",jsonlist);
		return viewpage;
	}
	
	//팀이슈 댓글 삭제
	@RequestMapping(value = "delComment.do",method = {RequestMethod.POST,RequestMethod.GET})
	public String delComment(int replyseq,Model model) {
		int result = 0;	
		String viewpage = "";
		result = tservice.delComment(replyseq);
		
		if(result > 0) {
			model.addAttribute("ajax","댓글 성공");
			viewpage = "utils/ajax";
			
		}else {
			model.addAttribute("ajax","댓글 실패");
			viewpage = "utils/ajax";
		}
		return viewpage;
	}
	
	//공지사항 삭제 처리 
	@RequestMapping(value="deleteNoitce.do",method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteNotice(int bnseq) {
		int result = 0;
		String viewpage;
		
		result = service.deleteNotice(bnseq);
		if(result > 0) {
			viewpage = "redirect:/notice.do";
		}else {
			viewpage = "redirect:/index.do";
		}
				
		return viewpage;
	}
	
	//프로젝트 공지사항 페이지 이동
	@RequestMapping(value="projectNotice.do", method = RequestMethod.GET)
	public String pjNotice(int tseq,Model model,HttpSession session) {
		String email = (String)session.getAttribute("email");
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		MemberDao md = sqlSession.getMapper(MemberDao.class);
		List<PjNotice> pj = dao.getPjNotice(tseq);
		TeamPjt pjt = dao.detailPJT(tseq);
		int rank = dao.searchRank(tseq, email);
		List<ProjectMemberlist> projectMemberlist =md.projectMemberlist(tseq);
		model.addAttribute("tpj", pjt);
		model.addAttribute("pjn", pj);	
		model.addAttribute("rank", rank);
		model.addAttribute("projectmember", projectMemberlist);
		
		
		return "user/ProjectNotice";
	}
	//프로젝트 공지사항 작성처리
	@RequestMapping(value = "PnoticeWrite.do" , method = RequestMethod.POST)
	public String pjNoticeWrite(PjNotice pjnotice) {
		int result = 0;
		String viewpage;
		
		result = tservice.pjNoticeWrite(pjnotice);
		
		if(result > 0) {
			viewpage = "redirect:/projectNotice.do?tseq="+pjnotice.getTseq();
		}else {
			viewpage = "user/userindex";
		}
		
		
		return viewpage;
	}
	//프로젝트 공지사항 상세보기
	@RequestMapping(value="pjNoticeDetail.do",method=RequestMethod.GET)
	public String pjNoticeDetail(int pnseq,Model model,HttpSession session,int tseq) {
		String email = (String)session.getAttribute("email");
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		int rank = dao.searchNoticeRank(pnseq, email, tseq);
		PjNotice Detail = dao.pjNoticeDetail(pnseq);
		model.addAttribute("rank", rank);
		model.addAttribute("detail", Detail);
		return "user/projectDetailNotice";
	}
	//프로젝트 공지사항 수정 
	@RequestMapping(value="pjNoticeEdit.do",method=RequestMethod.GET)
	public String pjNoticeEdit(int pnseq,Model model) {
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		PjNotice edit = dao.pjNoticeDetail(pnseq);
		
		model.addAttribute("edit",edit);
		return "user/projectEditNotice";
	}
	
	//프로젝트 공지사항 수정 처리 
	@RequestMapping(value="pjNoticeEditOk.do", method = RequestMethod.POST)
	public String pjNoticeEditOk(PjNotice pjnotice,int tseq) {
		String viewpage;
		int result = 0;
		result = tservice.pjNoticeEdit(pjnotice);
		if(result > 0) {
			viewpage = "redirect:/pjNoticeDetail.do?pnseq="+pjnotice.getPnseq()+"&tseq="+tseq;
		}else {
			viewpage = "user/projectNotice";
		}
		return viewpage;
	}
	
	//프로젝트 공지사항 삭제
	@RequestMapping(value="pjNoticeDelete.do" , method = {RequestMethod.POST, RequestMethod.GET})
	public String pjNoticeDelete(int pnseq,int tseq) {
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		int result = dao.deletePjNotice(pnseq);
		String viewpage;
		
		if(result > 0) {
			viewpage="redirect:/projectNotice.do?tseq="+tseq;
		}else {
			viewpage="user/ProjectNotice";
		}
		
		return viewpage;
	}
	//프라이빗 이슈 수정 불러오기
	@RequestMapping(value="myissueEdit.do" , method = {RequestMethod.POST, RequestMethod.GET})
	public String myissueEdit(int piseq, Model model) {
		MyIssueDao dao = sqlSession.getMapper(MyIssueDao.class);
		MyIssue myissue = dao.myissueDetail(piseq);
		/*if(myissue.getPicontent().contains("<a href=")) {
			int start = myissue.getPicontent().indexOf("<a href=");
			int end = myissue.getPicontent().indexOf("target='_blank'>");
			myissue.setPicontent(myissue.getPicontent().replace(myissue.getPicontent().substring(start, end+16), ""));
			myissue.setPicontent(myissue.getPicontent().replace("</a>", ""));
		}*/
		myissue.setPicontent(myissue.getPicontent().replace("<br>", "\n")); //textarea <br>치환
		try {
			List<Mention> mentions = dao.getMyMentions(piseq);
			List<GoogleDrive> googledrive = dao.getMyGoogleDrive(piseq);
			List<DoWork> dowork = dao.getMyDoWork(piseq);
			List<FileDrive> files = dao.getMyFiles(piseq);
			model.addAttribute("myissue", myissue);
			model.addAttribute("mentions", mentions);
			model.addAttribute("gdrive", googledrive);
			model.addAttribute("dowork", dowork);
			model.addAttribute("files", files);
		} catch (Exception e) {
			model.addAttribute("myissue", myissue);
		}
		return "issue/myissueEdit";
	}
	//협업공간 이슈 수정 불러오기
	@RequestMapping(value="teamIssueEdit.do" , method = {RequestMethod.POST, RequestMethod.GET})
	public String teamIssueEdit(int tiseq, Model model) {
		TissueDao dao = sqlSession.getMapper(TissueDao.class);
		Tissue tissue = dao.teamissueDetail(tiseq);
		tissue.setTicontent(tissue.getTicontent().replace("<br>", "\n")); //textarea <br>치환
		try {
			//List<Reply> reply = dao.teamCommentOk(tiseq);
			List<Mention> mentions = dao.getMentions(tiseq);
			List<GoogleDrive> googledrive = dao.getGoogleDrive(tiseq);
			List<DoWork> dowork = dao.getDoWork(tiseq);
			List<FileDrive> files = dao.getFiles(tiseq);
			//model.addAttribute("reply",reply);
			model.addAttribute("mentions",mentions);
			model.addAttribute("gdrive", googledrive);
			model.addAttribute("dowork", dowork);
			model.addAttribute("files", files);
			model.addAttribute("tissue", tissue);
		} catch (Exception e) {
			model.addAttribute("tissue", tissue);
		}
		return "issue/teamIssueEdit";
	}
	//프라이빗 이슈 수정하기
	@RequestMapping(value="myissueEditOk.do" , method = {RequestMethod.POST, RequestMethod.GET})
	public String myissueEditOk(int piseq,Model model, String[] editMention, String[] editGfilename, HttpSession session, HttpServletRequest request
			, String[] editGurl, String[] editToname, String[] editOriFile,String[] editDowork, String title, String editIssuecontent, String editFrom, String editTo, @RequestParam(value="editFile") MultipartFile[] editFile) throws Exception {
		String email = (String)session.getAttribute("email");
		if(editOriFile != null && editOriFile.length > 0) { 
			for(int i=0;i<editOriFile.length;i++) {
				if(editOriFile[i].contains("~delete")) {
					int pdseq = Integer.parseInt(editOriFile[i].split("~")[1]);
					privateservice.pfileDelete(pdseq); //만약 지운 파일이 있다면 DB에서 삭제
				}
			}
		}
		long fullSize = 0;
		List<Long> orifilesize = tservice.getMyOriFilesize(piseq);
		for(int i=0;i<orifilesize.size();i++) {
			fullSize += orifilesize.get(i); //삭제하고나서 남은 원래 파일들의 사이즈 측정
		}
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		Role role = dao.getUserRole(email); //사용자의 등급을 가져옴
		for(MultipartFile mutifile : editFile) {
			long fsize = mutifile.getSize();
			fullSize += fsize; //새로들어온 파일들의 사이즈 측정
		}
		if(role.getRname().equals("ROLE_USER")) {
			if(fullSize>=20971520) {
				return "utils/fileSizeFail"; //만약 무료회원이 20mb이상 업로드라면 이슈작성 실패
			}
		}else if(role.getRname().equals("ROLE_CHARGE")) {
			if(fullSize>=104857600) {
				return "utils/chargeFileSizeFail"; //만약 유료회원이 50mb이상 업로드라면 이슈작성 실패
			}
		}
		String path = "";
		MyIssue tissue = new MyIssue();
		tissue.setPiseq(piseq);
		tissue.setEmail(email);
		tissue.setPititle(title);
		
		//링크에 a tag 붙이기
		String[] contentline = editIssuecontent.split("\n"); 
		String content = "";
		String link = "";
		for(int i = 0; i < contentline.length; i++) {
			if(contentline[i].indexOf("http") != -1 || contentline[i].indexOf("www") != -1) {
				String[] url = contentline[i].split(" "); 
				for(int j = 0; j < url.length; j++) {
					if(url[j].indexOf("http") != -1 || url[j].indexOf("www") != -1) {
						if(url[j].indexOf("http") == -1) {
							link += "http://" + url[j] + ",";
						}else {
							link += url[j] + ",";
						}
						content += "<a href= "+ url[j] + " target='_blank'>" + url[j] + "</a> ";
					}else {
						content += url[j] + " ";
					}
				}
				content += "<br>";
			}else {
				content += contentline[i]+"<br>";
			}
		}
		content = content.replace("\r\n", "<br>"); //\r\n <br>로 치환
		tissue.setPicontent(content);
		if(!editFrom.equals("")) { //일정이 비지 않았다면 수정
			tissue.setPistart(java.sql.Timestamp.valueOf(editFrom+" 00:00:00"));
			tissue.setPiend(java.sql.Timestamp.valueOf(editTo+" 00:00:00"));
		}
		int result = privateservice.editMyissue(tissue); //프라이빗 이슈 수정
		if(editFile != null && editFile.length > 0) {
			//업로드한 파일이 하나라도 있다면
			for(MultipartFile mutifile : editFile) {
				String filename = mutifile.getOriginalFilename();
				long fsize = mutifile.getSize();
				String filepath = request.getServletContext().getRealPath("/upload");
				String fpath = filepath + "\\" + filename;
				if(!filename.equals("")) {
					//서버에 파일 업로드 (write)
					FileOutputStream fs = new FileOutputStream(fpath);
					fs.write(mutifile.getBytes());
					fs.close();
					try {
						privateservice.pfileEdit(filename, fsize, email, piseq); //새로올린 파일이 있다면 추가해줌
					} catch (Exception e) {
						privateservice.pfileEdit(filename, fsize, email, piseq); //새로올린 파일이 있다면 추가해줌
					}
				}
			}
		}
		if(editMention != null && editMention.length > 0) {
			for(int i=0;i<editMention.length;i++) {
				if(editMention[i].contains("~delete")) {
					int pmseq = Integer.parseInt(editMention[i].split("~")[1]);
					privateservice.pmentionDelete(pmseq); //만약 지운 멘션이 있다면 DB에서 삭제
				}else {
					if(!editMention[i].contains("~")) {
						//editMention[i] = editMention[i].split("~")[0];
						privateservice.pmentionEdit(editMention[i], piseq); //만약 추가된 멘션이 있다면 DB에서 추가
					}
				}
			}
		}
		if(editGfilename != null && editGfilename.length > 0) {
			for(int i=0;i<editGfilename.length;i++) {
				if(editGfilename[i].contains("~delete")) {
					int pgseq = Integer.parseInt(editGfilename[i].split("~")[1]);
					privateservice.pgoogleDriveDelete(pgseq); //만약 지운 구글드라이브가 있다면 DB에서 삭제
				}else {
					if(!editGfilename[i].contains("~")) {
						//editGfilename[i] = editGfilename[i].split("/")[0];
						//editGurl[i] = editGurl[i].split("/")[0];
						privateservice.pgoogleDriveEdit(editGfilename[i], editGurl[i], piseq); //만약 추가된 구글드라이브가 있다면 DB에서 추가
					}
				}
			}
		}
		if(editToname != null && editToname.length > 0) {
			String fromWork = email;
			for(int i=0;i<editToname.length;i++) {
				if(editToname[i].contains("~delete")) {
					int pwseq = Integer.parseInt(editToname[i].split("~")[1]);
					privateservice.pdoWorkDelete(pwseq); //만약 지운 할일이 있다면 DB에서 삭제
				}else {
					if(!editToname[i].contains("~")) {
						//editToname[i] = editToname[i].split("/")[0];
						//editDowork[i] = editDowork[i].split("/")[0];
						privateservice.pdoWorkEdit(fromWork, editToname[i], editDowork[i], piseq); //만약 추가된 할일이 있다면 DB에서 추가
					}
				}
			}
		}
		if(result >0) {
			model.addAttribute("piseq", piseq);
			path = "utils/editMyIssueSwal";
		}else {
			model.addAttribute("piseq", piseq);
			path = "utils/editMyIssueFailSwal";
		}
		return path;
	}
	//협업공간 이슈 수정하기
	@RequestMapping(value="teamIssueEditOk.do" , method = {RequestMethod.POST, RequestMethod.GET})
	public String teamIssueEditOk(int tseq, int tiseq,Model model, String[] editMention, String[] editGfilename, HttpSession session, HttpServletRequest request
			, String[] editGurl, String[] editToname, String[] editOriFile,String[] editDowork, String title, String editIssuecontent, String editFrom, String editTo, @RequestParam(value="editFile") MultipartFile[] editFile) throws Exception {
		String email = (String)session.getAttribute("email");
		 if(editOriFile != null && editOriFile.length > 0) {
			 for(int i=0;i<editOriFile.length;i++) {
				 if(editOriFile[i].contains("~delete")) {
					 int fdseq = Integer.parseInt(editOriFile[i].split("~")[1]);
					 tservice.fileDelete(fdseq); //만약 지운 파일이 있다면 DB에서 삭제
				 }
			 }
		 }
		long fullSize = 0;
		List<Long> orifilesize = tservice.getOriFilesize(tiseq); //원래 있던 파일들의 사이즈 측정
		for(int i=0;i<orifilesize.size();i++) {
			fullSize += orifilesize.get(i);
		}
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		Role role = dao.getUserRole(email); //현재 로그인된 멤버의 등급 불러오기
		for(MultipartFile mutifile : editFile) {
			long fsize = mutifile.getSize(); //새로 추가된 파일의 사이즈 측정
			fullSize += fsize;
		}
		if(role.getRname().equals("ROLE_USER")) {
			if(fullSize>=20971520) {
				return "utils/fileSizeFail"; //만약 무료회원이 20mb이상 업로드라면 이슈작성 실패
			}
		}else if(role.getRname().equals("ROLE_CHARGE")) {
			if(fullSize>=104857600) {
				return "utils/chargeFileSizeFail"; //만약 유료회원이 50mb이상 업로드라면 이슈작성 실패
			}
		}
		String path = "";
		MyIssue tissue = new MyIssue();
		tissue.setTseq(tseq);
		tissue.setTiseq(tiseq);
		tissue.setEmail(email);
		tissue.setTititle(title);
		String[] contentline = editIssuecontent.split("\n");
		String content = "";
		String link = "";
		for(int i = 0; i < contentline.length; i++) {
			if(contentline[i].indexOf("http") != -1 || contentline[i].indexOf("www") != -1) {
				String[] url = contentline[i].split(" ");
				for(int j = 0; j < url.length; j++) {
					if(url[j].indexOf("http") != -1 || url[j].indexOf("www") != -1) {
						if(url[j].indexOf("http") == -1) {
							link += "http://" + url[j] + ",";
						}else {
							link += url[j] + ",";
						}
						content += "<a href= "+ url[j] + " target='_blank'>" + url[j] + "</a> ";
					}else {
						content += url[j] + " ";
					}
				}
				content += "<br>";
			}else {
				content += contentline[i]+"<br>";
			}
		}
		editIssuecontent = content.replace("\r\n", "<br>"); // \r\n을 <br>로 치환
		tissue.setTicontent(editIssuecontent);
		if(!editFrom.equals("")) { //만약 일정이 비어있지 않다면 수정
			 tissue.setTistart(java.sql.Timestamp.valueOf(editFrom+" 00:00:00"));
			 tissue.setTiend(java.sql.Timestamp.valueOf(editTo+" 00:00:00"));
		}
		int result = privateservice.editTissue(tissue); //프라이빗 이슈 수정
		 if(editFile != null && editFile.length > 0) {
			 //업로드한 파일이 하나라도 있다면
			 for(MultipartFile mutifile : editFile) {
				 String filename = mutifile.getOriginalFilename();
					 long fsize = mutifile.getSize();
					 String filepath = request.getServletContext().getRealPath("/upload");
					 String fpath = filepath + "\\" + filename;
					 if(!filename.equals("")) {
						 //서버에 파일 업로드 (write)
						 FileOutputStream fs = new FileOutputStream(fpath);
						 fs.write(mutifile.getBytes());
						 fs.close();
						 try {
							 tservice.fileEdit(tseq, filename, fsize, email, tiseq); //만약 추가한 파일이 있다면 DB에서 추가
						 } catch (Exception e) {
							 tservice.fileEdit(tseq, filename, fsize, email, tiseq);
						 }
					 }
			 }
		 }
		 if(editMention != null && editMention.length > 0) {
			 for(int i=0;i<editMention.length;i++) {
				 if(editMention[i].contains("~delete")) {
					 int tmseq = Integer.parseInt(editMention[i].split("~")[1]);
					 tservice.mentionDelete(tmseq); //만약 지운 멘션이 있다면 DB에서 삭제
				 }else {
					 if(!editMention[i].contains("~")) {
						 //editMention[i] = editMention[i].split("~")[0];
						 tservice.mentionEdit(editMention[i], tiseq); //만약 추가한 멘션이 있다면 DB에서 추가
					 }
				 }
			 }
		 }
		 if(editGfilename != null && editGfilename.length > 0) {
			 for(int i=0;i<editGfilename.length;i++) {
				 if(editGfilename[i].contains("~delete")) {
					 int tgseq = Integer.parseInt(editGfilename[i].split("~")[1]);
					 tservice.googleDriveDelete(tgseq); //만약 지운 구글드라이브가 있다면 DB에서 삭제
				 }else {
					 if(editGfilename[i].contains("~")) {
						 //editGfilename[i] = editGfilename[i].split("/")[0];
						 //editGurl[i] = editGurl[i].split("/")[0];
					 }else {
						 tservice.googleDriveEdit(editGfilename[i], editGurl[i], tiseq); //만약 추가한 구글드라이브가 있다면 DB에서 추가
					 }
				 }
			 }
		 }
		 if(editToname != null && editToname.length > 0) {
			 String fromWork = email;
			 for(int i=0;i<editToname.length;i++) {
				 if(editToname[i].contains("~delete")) {
					 int tdseq = Integer.parseInt(editToname[i].split("~")[1]);
					 tservice.doWorkDelete(tdseq); //만약 지운 할일이 있다면 DB에서 삭제
				 }else {
					 if(!editToname[i].contains("~")) {
						 //editToname[i] = editToname[i].split("/")[0];
						 //editDowork[i] = editDowork[i].split("/")[0];
						 tservice.doWorkEdit(fromWork, editToname[i], editDowork[i], tiseq); //만약 추가한 할일이 있다면 DB에서 추가
					 }
				 }
			 }
		 }
		if(result >0) {
			model.addAttribute("tiseq", tiseq);
			path = "utils/editTeamIssueSwal";
		}else {
			model.addAttribute("tiseq", tiseq);
			path = "utils/editTeamIssueFailSwal";
		}
	return path;
	}
	//프라이빗 이슈 삭제
	@RequestMapping(value="deleteMyIssue.do" , method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteMyIssue(int piseq, Model model) {
		privateservice.myIssueFileDelete(piseq);
		privateservice.myIssueMentionDelete(piseq);
		privateservice.myIssueGoogleDriveDelete(piseq);
		privateservice.myIssueDoWorkDelete(piseq);
		privateservice.myIssueDelete(piseq);
		return "utils/myIssueDelete";
	}
	//협업공간 이슈 삭제
	@RequestMapping(value="deleteTeamIssue.do" , method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteTeamIssue(int tiseq,int tseq, Model model) {
		tservice.teamIssueFileDelete(tiseq);
		tservice.teamIssueMentionDelete(tiseq);
		tservice.teamIssueGoogleDriveDelete(tiseq);
		tservice.teamIssueDoWorkDelete(tiseq);
		tservice.teamIssueDelete(tiseq);
		model.addAttribute("tseq", tseq);
		return "utils/teamIssueDelete";
	}
}
