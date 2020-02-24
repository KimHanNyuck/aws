package kr.or.scoop.dto;


import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Repository
public class Tissue {
	
	private int tiseq;	//팀이슈번호
	private int tseq; 	//프로젝트 번호	
	private int tmseq;	//팀멘션 번호 
	private String email; //이슈 작성자 이메일
	private String tititle; // 팀이슈 제목
	private String ticontent;	//팀이슈 내용
	private List<CommonsMultipartFile> files; //올린 파일 목록
	private String tfilename; //파일 이름
	private Timestamp tistart; //일정 시작
	private Timestamp tiend;   //일정 끝
	private String isprocess; //진행과정
	private String backgroundColor; //캘린더 일정 색상
	private String textColor; //캘린더 일정 글자 색상
	private int allDay; //캘린더 하루 종일 여부 

	
	private long tfilesize;
	private int istbook;
	private int issee;
	private Timestamp tidate;
	private String tgfilename;
	private String tmemail;
	private String turl;
	private String name;
	private String pname;
	
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getAllDay() {
		return allDay;
	}
	public void setAllDay(int allDay) {
		this.allDay = allDay;
	}
	public String getTgfilename() {
		return tgfilename;
	}
	public void setTgfilename(String tgfilename) {
		this.tgfilename = tgfilename;
	}

	public String getTurl() {
		return turl;
	}
	public void setTurl(String turl) {
		this.turl = turl;
	}
	public int getTiseq() {
		return tiseq;
	}
	public void setTiseq(int tiseq) {
		this.tiseq = tiseq;
	}
	public int getTseq() {
		return tseq;
	}
	public void setTseq(int tseq) {
		this.tseq = tseq;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTititle() {
		return tititle;
	}
	public void setTititle(String tititle) {
		this.tititle = tititle;
	}
	public String getTicontent() {
		return ticontent;
	}
	public void setTicontent(String ticontent) {
		this.ticontent = ticontent;
	}
	
	public String getIsprocess() {
		return isprocess;
	}
	public void setIsprocess(String isprocess) {
		this.isprocess = isprocess;
	}

	
	public long getTfilesize() {
		return tfilesize;
	}
	public void setTfilesize(long tfilesize) {
		this.tfilesize = tfilesize;
	}
	public int getIstbook() {
		return istbook;
	}
	public void setIstbook(int istbook) {
		this.istbook = istbook;
	}
	public int getIssee() {
		return issee;
	}
	public void setIssee(int issee) {
		this.issee = issee;
	}
	
	public Timestamp getTidate() {
		return tidate;
	}
	public void setTidate(Timestamp tidate) {
		this.tidate = tidate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getTmseq() {
		return tmseq;
	}
	public void setTmseq(int tmseq) {
		this.tmseq = tmseq;
	}
	public String getTmemail() {
		return tmemail;
	}
	public void setTmemail(String tmemail) {
		this.tmemail = tmemail;
	}
	public List<CommonsMultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<CommonsMultipartFile> files) {
		this.files = files;
	}
	public String getTfilename() {
		return tfilename;
	}
	public void setTfilename(String tfilename) {
		this.tfilename = tfilename;
	}
	
	public Timestamp getTistart() {
		return tistart;
	}
	public void setTistart(Timestamp tistart) {
		this.tistart = tistart;
	}
	public Timestamp getTiend() {
		return tiend;
	}
	public void setTiend(Timestamp tiend) {
		this.tiend = tiend;
	}
	public String getBackgroundColor() {
		return backgroundColor;
	}
	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}
	public String getTextColor() {
		return textColor;
	}
	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}
	@Override
	public String toString() {
		return "Tissue [tiseq=" + tiseq + ", tseq=" + tseq + ", tmseq=" + tmseq + ", email=" + email + ", tititle="
				+ tititle + ", ticontent=" + ticontent + ", files=" + files + ", tfilename=" + tfilename + ", tistart="
				+ tistart + ", tiend=" + tiend + ", isprocess=" + isprocess + ", backgroundColor=" + backgroundColor
				+ ", textColor=" + textColor + ", allDay=" + allDay + ", tfilesize=" + tfilesize + ", istbook="
				+ istbook + ", issee=" + issee + ", tidate=" + tidate + ", tgfilename=" + tgfilename + ", tmemail="
				+ tmemail + ", turl=" + turl + ", name=" + name + ", pname=" + pname + "]";
	}
	
	
	

	
	
}
