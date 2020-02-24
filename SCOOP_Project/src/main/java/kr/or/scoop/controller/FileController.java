package kr.or.scoop.controller;

import java.io.FileInputStream;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.scoop.dao.MemberDao;
import kr.or.scoop.dao.MyIssueDao;
import kr.or.scoop.dao.TissueDao;
import kr.or.scoop.dto.FileDrive;
import kr.or.scoop.dto.Link;
import kr.or.scoop.dto.PrivateFileDrive;
import net.sf.json.JSONArray;

@Controller
public class FileController {
	
	@Autowired
	private SqlSession sqlsession;
	//파일을 클릭하면 다운로드
	@RequestMapping("/fileDownload.do")
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String realPath = "C:/SmartWeb/FinalProjectEclipse/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/SCOOP_Project/upload/";
		String p = "upload";
		String f = request.getParameter("fileName");
		
		String fname = new String(f.getBytes("euc-kr"), "8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fname + ";");
		// 파일명 전송
		// 파일 내용전송
		String fullpath = request.getServletContext().getRealPath(p + "/" + f);
		FileInputStream fin = new FileInputStream(fullpath);
		// 출력 도구 얻기 :response.getOutputStream()
		ServletOutputStream sout = response.getOutputStream();
		byte[] buf = new byte[1024]; // 전체를 다읽지 않고 1204byte씩 읽어서
		int size = 0;
		while ((size = fin.read(buf, 0, buf.length)) != -1) // buffer 에 1024byte
		// 담고
		{ // 마지막 남아있는 byte 담고 그다음 없으면 탈출
			sout.write(buf, 0, size); // 1kbyte씩 출력
		}
		fin.close();
		sout.close();
	}
	//파일함에서 select 협업공간 변경하면 비동기로 파일 리스트 바꿔줌
	@RequestMapping("/fileChange.do")
	public String fileChange(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		String email = (String)session.getAttribute("email");
		int tseq = Integer.parseInt(request.getParameter("tseq"));
		if(tseq == 0) {
			List<FileDrive> filedrive = memberdao.getFileDrive(email);
			JSONArray jsonlist = JSONArray.fromObject(filedrive);
			model.addAttribute("ajax",jsonlist);
		}else {
			List<FileDrive> filedrive = memberdao.getFileProject(tseq);
			JSONArray jsonlist = JSONArray.fromObject(filedrive);
			model.addAttribute("ajax",jsonlist);
		}
		return "utils/ajax";
	}
	//파일함에서 select 내파일로 변경하면 비동기로 파일 리스트 바꿔줌
	@RequestMapping("/myFileSelect.do")
	public String myFileSelect(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		String email = (String)session.getAttribute("email");
			List<PrivateFileDrive> filedrive = memberdao.getMyFile(email);
			JSONArray jsonlist = JSONArray.fromObject(filedrive);
			model.addAttribute("ajax",jsonlist);
		return "utils/ajax";
	}
	//파일함에서 비동기로 검색
	@RequestMapping("/teamFileSearch.do")
	public String teamFileSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		String email = (String)session.getAttribute("email");
		String word = request.getParameter("word");
			List<FileDrive> filedrive = memberdao.searchFileDrive(email, word);
			JSONArray jsonlist = JSONArray.fromObject(filedrive);
			model.addAttribute("ajax",jsonlist);
		return "utils/ajax";
	}
	//파일함에서 비동기로 검색
	@RequestMapping("/myFileSearch.do")
	public String myFileSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		String email = (String)session.getAttribute("email");
		String word = request.getParameter("word");
		List<FileDrive> filedrive = memberdao.searchMyFileDrive(email, word);
		JSONArray jsonlist = JSONArray.fromObject(filedrive);
		model.addAttribute("ajax",jsonlist);
		return "utils/ajax";
	}
	
	//마이 링크 리스트
	@RequestMapping("/getMyLink.do")
	public String getMyLink(HttpSession session, Model model) {
		String email = (String)session.getAttribute("email");
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		
		List<Link> link = dao.getMyLink(email);
		JSONArray jsonlist = JSONArray.fromObject(link);
		model.addAttribute("ajax", jsonlist);
		
		return "utils/ajax";
	}
	
	//팀 링크 리스트
	@RequestMapping("/getTLink.do")
	public String getTLink(HttpSession session, Model model, HttpServletRequest request) {
		String email = (String)session.getAttribute("email");
		int tseq = Integer.parseInt(request.getParameter("tseq"));
		
		System.out.println("email : " + email);
		System.out.println("tseq : " + tseq);
		
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		
		List<Link> link = dao.getTLink(tseq);
		JSONArray jsonlist = JSONArray.fromObject(link);
		System.out.println(link);
		model.addAttribute("ajax", jsonlist);
		
		return "utils/ajax";
	}
}
