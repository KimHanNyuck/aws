package kr.or.scoop.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.LocaleResolver;

import kr.or.scoop.dao.MemberDao;
import kr.or.scoop.dao.MyIssueDao;
import kr.or.scoop.dao.ProjectDao;
import kr.or.scoop.dao.TissueDao;
import kr.or.scoop.dto.BookMark;
import kr.or.scoop.dto.FileDrive;
import kr.or.scoop.dto.Member;
import kr.or.scoop.dto.MyIssue;
import kr.or.scoop.dto.Process;
import kr.or.scoop.dto.ProjectMemberlist;
import kr.or.scoop.dto.Role;
import kr.or.scoop.dto.TeamPjt;
import kr.or.scoop.dto.Tissue;
import kr.or.scoop.dto.Tpmember;
import kr.or.scoop.service.BoardService;
import kr.or.scoop.service.PrivateService;
import kr.or.scoop.service.TeamService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class TeamController {
	
    @Autowired
    private SqlSession sqlsession;
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private TeamService teamservice;
	
	@Autowired
	private PrivateService privateservice;
	
	@Autowired
	private LocaleResolver localeResolver;
	//협업공간 생성
	@RequestMapping(value = "team.do" , method= {RequestMethod.POST,RequestMethod.GET})
	public String CreateProject(TeamPjt team) {
		int result = 0;
		String viewpage;
		
		result = service.insertTeamPjt(team);
		
		if(result > 0) {
			viewpage = "redirect:/userindex.do";
		}else {
			viewpage = "redirect:/userindex.do";
		}
		return viewpage;
		
	}
	//협업공간 초대되면 DB에 멤버 추가
	@RequestMapping(value = "inviteOk.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String normalInsert(HttpSession session) throws ClassNotFoundException, SQLException {
		int result = 0;
		String viewpage = "";
		String email = (String)session.getAttribute("mailTo");
		String temptseq = (String)session.getAttribute("tseq");
		int tseq = Integer.parseInt(temptseq);
		result = service.insertTeamPjt2(email, tseq);
		if (result > 0) {
			viewpage = "utils/inviteSuccessSwal";
		} else {
			viewpage = "utils/inviteFailSwal";
		}

		return viewpage; // 주의 (website/index.htm

	}
	//협업공간 초대 인증
	@RequestMapping(value = "/invitecertified.do")
	public String certified(int tseq, String mailTo) {
		String path = "";
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		Role role = dao.getUserRole(mailTo);
		if(role.getRname().equals("ROLE_USER")) {
			int count = dao.getCountProject(mailTo);
			if(count>=3) {
				path =  "utils/rejectInvite";
			}else {
				path = "certified/InviteCertified";
			}
		}else {
			path = "certified/InviteCertified";
		}
		
		return path;
	}
	
	//협업공간 디테일 
	@RequestMapping(value = "projectDetail.do" , method = RequestMethod.GET)
	public String projectDetail(HttpSession session, int tseq, Model model) {
		String email = (String)session.getAttribute("email");
		
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		MemberDao md = sqlsession.getMapper(MemberDao.class);
		MyIssueDao mydao = sqlsession.getMapper(MyIssueDao.class);
		
		TeamPjt pjt = dao.detailPJT(tseq);
		List<Tissue> tp = dao.getTissue(tseq); //협업공간 이슈 목록 불러오기
		for(int i=0; i<tp.size();i++) {
			tp.get(i).setTicontent(tp.get(i).getTicontent().replace("<br>", " ")); //<br> 띄어쓰기로 치환
		}
		List<ProjectMemberlist> projectMemberlist =md.projectMemberlist(tseq); //프로젝트 멤버 리스트 불러오기
		List<BookMark> bookMark = mydao.getBookMark(email); //북마크 불러오기
		Tpmember myInfo = md.getMyInfo(tseq, email);
		
		int rank = dao.searchRank(tseq, email);
		
		model.addAttribute("tpj",pjt); //프로젝트 이름 , 설명
		model.addAttribute("tp",tp); //프로젝트 글 목록
		model.addAttribute("projectmember", projectMemberlist);
		model.addAttribute("rank", rank);
		model.addAttribute("bookMark", bookMark);
		model.addAttribute("myInfo", myInfo);
		List<FileDrive> filedrive = null;
		try {
			 filedrive = md.getFileDrive(email);
		} catch (Exception e) {
			// TODO: handle exception
		}
		session.setAttribute("filed", filedrive);
		return "user/ProjectDetail";
		
	}
	
	// 이슈 작성
		@RequestMapping(value = "writeIssue.do", method = {RequestMethod.POST,RequestMethod.GET})
		public String writeIssue(String issuetitle, String fileclick, String issuecontent, String selectTeam, Model model, String fromDate, String toDate,
				HttpSession session,HttpServletRequest request, String[] mentions, String[] toWork, String[] doWork, String[] googleDrive,@RequestParam(value="files") MultipartFile[] files) throws IOException {
			String email = (String)session.getAttribute("email");
			ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
			Role role = dao.getUserRole(email);
			long fullSize = 0;
			for(MultipartFile mutifile : files) { //파일들의 사이즈 측정
				long fsize = mutifile.getSize();
				fullSize += fsize;
			}
			if(role.getRname().equals("ROLE_USER")) {
				if(fullSize>=20971520) {
					return "utils/fileSizeFail"; //무료회원은 20mb 넘어가면 이슈작성 실패
				}
			}else if(role.getRname().equals("ROLE_CHARGE")) {
				if(fullSize>=104857600) {
					return "utils/chargeFileSizeFail"; //유료회원은 50mb 넘어가면 이슈작성 실패
				}
			}
			// 이슈 내용에서 url 찾아서 링크 (a태그)
			String[] contentline = issuecontent.split("\n");
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
			
			String path = "";
			int tseq = 0;
			//만약 선택한 팀의 번호가 자신의 이메일이라면 프라이빗 이슈 작성
			if (selectTeam.equals((String) session.getAttribute("email")) || selectTeam == null) {
				MyIssue myissue = new MyIssue();
				myissue.setEmail((String) session.getAttribute("email"));
				myissue.setPititle(issuetitle);
				issuecontent = issuecontent.replace("\r\n", "<br>"); //\r\n <br>로 치환
				myissue.setPicontent(content);
				myissue.setIspibook(0);
				if(fromDate != null) { //일정이 비어있지 않다면 추가
					 myissue.setPistart(java.sql.Timestamp.valueOf(fromDate+" 00:00:00"));
					 myissue.setPiend(java.sql.Timestamp.valueOf(toDate+" 00:00:00"));
				}
				int result = privateservice.writeMyissue(myissue); //이슈 추가
				 if(files != null && files.length > 0) {
					 //업로드한 파일이 하나라도 있다면
					 for(MultipartFile mutifile : files) {
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
								 teamservice.myFileInsert(filename, fsize, email); //내 파일함에 파일 추가
							 } catch (Exception e) {
								 teamservice.myFileInsert(filename, fsize, email);
							 }
						 }
					 }
				 }
				 if(mentions != null && mentions.length > 0) {
					 for(int i=0;i<mentions.length;i++) {
						 teamservice.myMentionInsert(mentions[i]); //프라이빗 멘션 추가
					 }
				 }
				 if(googleDrive != null && googleDrive.length > 0) {
					 String gfilename = "";
					 String gfileurl = "";
					 for(int i=0;i<googleDrive.length;i++) {
						 gfileurl = googleDrive[i].split("~")[0];
						 gfilename = googleDrive[i].split("~")[1];
						 teamservice.myGoogleDriveInsert(gfilename, gfileurl); //프라이빗 구글드라이브 추가
					 }
				 }
				 if(toWork != null && toWork.length > 0) {
					 String fromWork = email;
					 for(int i=0;i<toWork.length;i++) {
						 teamservice.myDoWorkInsert(fromWork, toWork[i], doWork[i]); //프라이빗 할일 추가
					 }
				 }
				if(result >0) {
					int piseq = teamservice.getMaxMyTiseq();
					model.addAttribute("piseq", piseq);
					path = "utils/makeMyIssueSwal";
				}else {
					path = "utils/makeMyIssueFailSwal";
				}
				if(link != null && link.length() > 0) {
					privateservice.myLinkInsert(link, email); // 링크가 있다면 DB insert
				}
				return path;
			} else { //tseq가 존재한다면 협업공간 이슈 작성
				MyIssue tissue = new MyIssue();
				tissue.setTseq(Integer.parseInt(selectTeam));
				tissue.setEmail((String)session.getAttribute("email"));
				tissue.setTititle(issuetitle);
				issuecontent = issuecontent.replace("\r\n", "<br>"); //\r\n <br>로 치환
				tissue.setTicontent(content);
				if(fromDate != null) { //일정이 있다면 추가
					 tissue.setTistart(java.sql.Timestamp.valueOf(fromDate+" 00:00:00"));
					 tissue.setTiend(java.sql.Timestamp.valueOf(toDate+" 00:00:00"));
				}
				int result = privateservice.writeTissue(tissue);
				 if(files != null && files.length > 0) {
					 //업로드한 파일이 하나라도 있다면
					 for(MultipartFile mutifile : files) {
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
								 tseq = Integer.parseInt(selectTeam);
								 teamservice.fileInsert(tseq, filename, fsize, email); //협업공간 파일함에 추가
							 } catch (Exception e) {
								 tseq = Integer.parseInt(selectTeam);
								 teamservice.fileInsert(tseq, filename, fsize, email);
							 }
						 }
					 }
				 }
				 if(mentions != null && mentions.length > 0) {
					 for(int i=0;i<mentions.length;i++) {
						 teamservice.mentionInsert(mentions[i]); //협업공간 멘션에 추가
					 }
				 }
				 if(googleDrive != null && googleDrive.length > 0) {
					 String gfilename = "";
					 String gfileurl = "";
					 for(int i=0;i<googleDrive.length;i++) {
						 gfileurl = googleDrive[i].split("~")[0];
						 gfilename = googleDrive[i].split("~")[1];
						 teamservice.googleDriveInsert(gfilename, gfileurl); //협업공간 구글드라이브에 추가
					 }
				 }
				 if(toWork != null && toWork.length > 0) {
					 String fromWork = email;
					 for(int i=0;i<toWork.length;i++) {
						 teamservice.doWorkInsert(fromWork, toWork[i], doWork[i]); //협업공간 할일에 추가
					 }
				 }
				if(result >0) {
					int tiseq = teamservice.getMaxTiseq();
					model.addAttribute("tiseq", tiseq);
					path = "utils/makeTeamIssueSwal";
				}else {
					tseq = Integer.parseInt(selectTeam);
					model.addAttribute("tseq", tseq);
					path = "utils/makeTeamIssueFailSwal";
				}
				if(link != null && link.length() > 0) {
					tseq = Integer.parseInt(selectTeam);
					teamservice.teamLinkInsert(tseq, link, email); // 링크가 있다면 DB insert
				}
			}
			return path;

		}
	
	
	//협업공간 칸반 불러오기
	@RequestMapping(value = "cooperation-kanban.do", method = RequestMethod.GET)
	public String kanbanView(int tseq, Model model,HttpSession session) {
		String path = "";
		String email = (String)session.getAttribute("email");
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<Tissue> tissuelist = teamservice.loadKanban(tseq);
		TeamPjt pjt = dao.detailPJT(tseq);
		int rank = dao.searchRank(tseq, email);
		model.addAttribute("rank", rank);
		model.addAttribute("tpj",pjt); //프로젝트 이름 , 설명
		if(tissuelist.isEmpty()) {
			path = "cooperation/cooperation-kanban";
		} else {
			path = "cooperation/cooperation-kanban";
			model.addAttribute("tissuelist", tissuelist);
		}
		return path;

	}
	
	//협업공간 설정
	@RequestMapping(value = "teamSetting.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String teamSetting(int tseq, String[] email, int[] pjuserrank, Model model,TeamPjt teampjt) {
		int result = 0;
		String viewpage;
		
		//result = teamservice.teamSetting(pjuserrank, tseq, email);
		result = teamservice.teamUpdate(teampjt);
		
		if(result > 0) {
			viewpage = "redirect:/projectDetail.do?tseq="+tseq;
		}else {
			viewpage = "redirect:/userindex.do";
		}
		return viewpage;
		
	}
	//협업공간 칸반 수정
	@RequestMapping(value = "kanbanEdit.do", method = RequestMethod.POST)
	public String kanbanEdit(int tseq, int tiseq, int isprocess, Model model) {
		String path = "";
		int result = 0;
		result = teamservice.EditKanban(tseq, tiseq, isprocess);
		if(result>0) {
			path = "redirect:/cooperation-kanban.do?tseq="+tseq;
		} else {
			path = "redirect:/cooperation-kanban.do?tseq="+tseq;
		}
		return path;
	}

	//협업공간 탈퇴하기
	@RequestMapping(value = "getOutTeam.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String getOutTeam(int tseq, String email, Model model) {
		int result = 0;
		String viewpage;
		result = teamservice.banMember(tseq, email);
		
		if(result > 0) {
			viewpage = "redirect:/userindex.do";
		}else {
			viewpage = "redirect:/userindex.do";
		}
		return viewpage;
		
	}
	//협업공간 멤버탈퇴시키기
	@RequestMapping(value = "banMember.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String banMember(int tseq, String email, Model model) {
		int result = 0;
		String viewpage;
		result = teamservice.banMember(tseq, email);
		
		if(result > 0) {
			model.addAttribute("ajax", "멤버탈퇴 성공했습니다");
			viewpage = "utils/ajax";
		}else {
			model.addAttribute("ajax", "멤버탈퇴 실패했습니다");
			viewpage = "utils/ajax";
		}
		return viewpage;
		
	}
	//협업공간 팀장 위임하기
	@RequestMapping(value = "changeManager.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String changeManager(int tseq, String email, Model model, HttpSession session) {
		int result = 0;
		String viewpage;
		String myEmail = (String)session.getAttribute("email");
		result = teamservice.changeManager(tseq, email);
		result = teamservice.changeManagerTp(tseq, email);
		result = teamservice.changeManagerTp2(tseq, myEmail);
		if(result > 0) {
			//model.addAttribute("ajax", "관리자변경 성공했습니다");
			viewpage = "redirect:/projectDetail.do?tseq="+tseq;
		}else {
			//model.addAttribute("ajax", "관리자변경 실패했습니다");
			viewpage = "redirect:/projectDetail.do?tseq="+tseq;
		}
		return viewpage;
		
	}
	//협업공간 삭제하기(팀장만 가능)
	@RequestMapping(value = "dropProjet.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String dropProjet(int tseq, Model model) {
		int result = 0;
		String viewpage;
		result = teamservice.dropProject(tseq);
		if(result > 0) {
			viewpage = "redirect:/userindex.do";
		}else {
			viewpage = "redirect:/userindex.do";
		}
		return viewpage;
		
	}
	//대시보드에 협업공간별로 차트 변경
	@ResponseBody
	@RequestMapping(value="selectChart.do", method = RequestMethod.POST)
	public Process chart(int tseq) {
		
		Process processList = null;
		
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		
		try {
			processList = dao.chartData(tseq);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return processList;
	}
	//협업공간 캘린더 이슈 작성
	@RequestMapping(value = "addTeamCalendar.do", method = RequestMethod.POST)
	public String addTeamCalendar(HttpSession session,String title, String start, String end, String description, String type, String username, String backgroundColor, String textColor, String allDay, int tseq) {
		int result = 0;
		String viewpage = "";
		Tissue tissue = new Tissue();
		MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
		tissue.setTititle(title);
		tissue.setEmail((String)session.getAttribute("email"));
		tissue.setTicontent(description);
		tissue.setTseq(tseq);
		tissue.setBackgroundColor(backgroundColor);
		tissue.setTextColor(textColor);
		int alldayReturn = 0;
		if(allDay.equals("true")) {
			alldayReturn = 1;
		} else {
			alldayReturn = 0;
		}
		tissue.setAllDay(alldayReturn);
		if(start.length()==16) {
			tissue.setTistart(java.sql.Timestamp.valueOf(start+":00"));
			tissue.setTiend(java.sql.Timestamp.valueOf(end+":00"));
			result = myissuedao.writeCalendarTissue(tissue);
		} else {
			tissue.setTistart(java.sql.Timestamp.valueOf(start+" 00:00:00"));
			tissue.setTiend(java.sql.Timestamp.valueOf(end+" 00:00:00"));
			result = myissuedao.writeCalendarTissue(tissue);
		}
		
		if(result>0) {
			viewpage = "redirect:/calendar.do";
		} else {
			viewpage = "redirect:/calendar.do";
		}
		
		return viewpage;
		
	}
	//프라이빗공간 캘린더 이슈 작성
	@RequestMapping(value = "editTeamCalendar.do", method = RequestMethod.POST)
	public String editTeamCalendar(int _id, String title, String start, String end, String description, String type, String backgroundColor, boolean allDay) {
		int result = 0;
		String viewpage = "";
		Tissue tissue = new Tissue();
		MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
		tissue.setTititle(title);
		tissue.setTicontent(description);
		tissue.setTiseq(_id);
		tissue.setBackgroundColor(backgroundColor);
		if(backgroundColor==null) {
			tissue.setBackgroundColor("#D25565");
		}
		if(start.length()==16) {
			tissue.setAllDay(0);
			tissue.setTistart(java.sql.Timestamp.valueOf(start+":00"));
			tissue.setTiend(java.sql.Timestamp.valueOf(end+":00"));
			result = myissuedao.editTeamCalendar(tissue);
		} else {
			tissue.setAllDay(1);
			tissue.setTistart(java.sql.Timestamp.valueOf(start+" 00:00:00"));
			tissue.setTiend(java.sql.Timestamp.valueOf(end+" 00:00:00"));
			result = myissuedao.editTeamCalendar(tissue);
		}
		
		
		if(result>0) {
			viewpage = "redirect:/calendar.do";
		} else {
			viewpage = "redirect:/calendar.do";
		}
		
		return viewpage;
		
	}
	//협업공간 캘린더 이슈 삭제
	@RequestMapping(value = "deleteTeamCalendar.do", method = RequestMethod.POST)
	public String deleteTeamCalendar(int tiseq, String username, HttpSession session) {
		int result = 0;
		String viewpage = "";
		Tissue tissue = new Tissue();
		MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
		tissue.setTiseq(tiseq);
		try {
			String name = (String)session.getAttribute("name");
			if(name.equals(username)) {
				result = myissuedao.deleteTeamCalendar(tissue);
				if(result>0) {
					viewpage = "redirect:/calendar.do";
				} else {
					viewpage = "redirect:/calendar.do";
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return viewpage;
		
	}
	//협업공간 캘린더 이슈 디테일 불러오기
	@ResponseBody
	@RequestMapping(value="getTeamCalendar.do", method = RequestMethod.GET)
	public JSONArray getTeamCalendar(HttpSession session, HttpServletResponse response, Model model) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		String email = (String)session.getAttribute("email");
		ProjectDao projectdao = sqlsession.getMapper(ProjectDao.class);
		TissueDao tissuedao = sqlsession.getMapper(TissueDao.class);
		List<Tpmember> pjtlist = projectdao.getPJT(email);
		List<Tissue> temptissuelist;
		Map<Integer, Tissue> sortlist = new HashMap<Integer, Tissue>();
		JSONArray jArray = new JSONArray();
		int tempnum = 0;
		for(Tpmember tpmember : pjtlist) {
			 temptissuelist = tissuedao.getTissueList(tpmember.getTseq());
			 for(Tissue tissue : temptissuelist) {
				 if(tissue.getTistart()!=null) {
					 sortlist.put(tempnum++, tissue);
				 }
			 }
		}
		try {
			Iterator<Integer> tissueitor = sortlist.keySet().iterator();
			SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd'T'HH:mm" , Locale.KOREA );
			SimpleDateFormat sdft = new SimpleDateFormat( "yyyy-MM-dd");
			while(tissueitor.hasNext()) {
				int key =tissueitor.next();
				JSONObject data = new JSONObject();
				int z = sortlist.get(key).getAllDay();
				
				data.put("_id", sortlist.get(key).getTiseq());
				data.put("title", sortlist.get(key).getTititle());
				data.put("description", sortlist.get(key).getTicontent());
				boolean allDay;
				if(z==0) {
					allDay = false;
					data.put("start", (String)sdf.format(sortlist.get(key).getTistart()).toString());
					data.put("end", (String)sdf.format(sortlist.get(key).getTiend()).toString());
				} else {
					allDay = true;
					data.put("start", (String)sdft.format(sortlist.get(key).getTistart()).toString());
					data.put("end", (String)sdft.format(sortlist.get(key).getTiend()).toString());
				}
				for(Tpmember tpmember : pjtlist) {
					if(tpmember.getTseq() == sortlist.get(key).getTseq()) {
						data.put("type", tpmember.getPname());
					}
				}
				
				data.put("username", sortlist.get(key).getName());
				data.put("backgroundColor", sortlist.get(key).getBackgroundColor());
				data.put("textColor", sortlist.get(key).getTextColor());
				
				data.put("allDay", allDay);
				data.put("tiseq", sortlist.get(key).getTiseq());
				jArray.add(data);
				
			}
			MyIssueDao myissuedao = sqlsession.getMapper(MyIssueDao.class);
			List<MyIssue> myissuelist = myissuedao.getMyissue(email);
			if(!myissuelist.isEmpty()) {
				for(MyIssue myissue : myissuelist) {
					if(myissue.getPistart()!=null) {
					JSONObject data = new JSONObject();
					int y = myissue.getAllDay();
					
					data.put("_id", myissue.getPiseq());
					data.put("title", myissue.getPititle());
					data.put("description", myissue.getPicontent());
					boolean allDay;
					if(y==0) {
						allDay = false;
						data.put("start", (String)sdf.format(myissue.getPistart()).toString());
						data.put("end", (String)sdf.format(myissue.getPiend()).toString());
					} else {
						allDay = true;
						data.put("start", (String)sdft.format(myissue.getPistart()).toString());
						data.put("end", (String)sdft.format(myissue.getPiend()).toString());
					}
					
					data.put("type", "프라이빗 공간");
					
					
					data.put("username", session.getAttribute("name"));
					data.put("backgroundColor", myissue.getBackgroundColor());
					data.put("textColor", myissue.getTextColor());
					
					data.put("allDay", allDay);
					jArray.add(data);
				}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		return jArray;
	}
	//사다리타기 불러오기
	@RequestMapping(value="projectLadder.do",method = RequestMethod.GET)
	public String ladder(int tseq,Model model) {
		
		return "user/projectLadder";
	}
	//전체 캘린더 불러오기
	@RequestMapping("/calendar.do")
	public String object(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		
		String email = (String)session.getAttribute("email");
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<Tpmember> mem = dao.getTpMember(email);
		
		model.addAttribute("mem",mem);
		return "sidebar/calendar";
	}
	//협업공간 캘린더 불러오기
	@RequestMapping("/projectCalendar.do")
	public String teamCalendar(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session, int tseq) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		String email = (String)session.getAttribute("email");
		TeamPjt pjt = dao.detailPJT(tseq);
		int rank = dao.searchRank(tseq, email);
		model.addAttribute("rank", rank);
		model.addAttribute("tpj",pjt); //프로젝트 이름 , 설명
		List<ProjectMemberlist> mem = memberdao.projectMemberlist(tseq);
		
		model.addAttribute("mem",mem);
		
		return "user/ProjectCalendar";
	}
	
	//협업공간 캘린더 내용 비동기 불러오기
	@ResponseBody
	@RequestMapping(value="getSelectTeamCalendar.do", method = RequestMethod.GET)
	public JSONArray getSelectTeamCalendar(HttpSession session, HttpServletResponse response, Model model, int tseq) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		String email = (String)session.getAttribute("email");
		ProjectDao projectdao = sqlsession.getMapper(ProjectDao.class);
		TissueDao tissuedao = sqlsession.getMapper(TissueDao.class);
		List<Tpmember> pjtlist = projectdao.getPJT(email);
		List<Tissue> temptissuelist;
		Map<Integer, Tissue> sortlist = new HashMap<Integer, Tissue>();
		JSONArray jArray = new JSONArray();
		
		int tempnum = 0;
		temptissuelist = tissuedao.getTissueList(tseq);
		SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd'T'HH:mm" , Locale.KOREA );
		SimpleDateFormat sdft = new SimpleDateFormat( "yyyy-MM-dd");
		
			if(!temptissuelist.isEmpty()) {
				for(Tissue tissue : temptissuelist) {
					if(tissue.getTistart()!=null) {
					JSONObject data = new JSONObject();
					int z = tissue.getAllDay();
					
					data.put("_id", tissue.getTiseq());
					data.put("title", tissue.getTititle());
					data.put("description", tissue.getTicontent());
					boolean allDay;
					if(z==0) {
						allDay = false;
						data.put("start", (String)sdf.format(tissue.getTistart()).toString());
						data.put("end", (String)sdf.format(tissue.getTiend()).toString());
					} else {
						allDay = true;
						data.put("start", (String)sdft.format(tissue.getTistart()).toString());
						data.put("end", (String)sdft.format(tissue.getTiend()).toString());
					}
					for(Tpmember tpmember : pjtlist) {
						if(tpmember.getTseq() == tissue.getTseq()) {
							data.put("type", tpmember.getPname());
						}
					}
					
					data.put("username", tissue.getName());
					data.put("backgroundColor", tissue.getBackgroundColor());
					data.put("textColor", tissue.getTextColor());
					
					data.put("allDay", allDay);
					data.put("tiseq", tissue.getTiseq());
					jArray.add(data);
				}
					
				}
			}
		return jArray;
	}
	
	
}
