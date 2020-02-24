package kr.or.scoop.dto;


import java.sql.Date;
import java.sql.Timestamp;
import java.util.Arrays;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
//프라이빗 이슈
@Repository
public class MyIssue {
	private int tseq; //협업공간 번호
	private int piseq; //프라이빗 이슈 번호
	private int tiseq; //협업공간 이슈 번호
	private String pfilename; //프라이빗 파일 이름
	private String pfilesize; //프라이빗 파일 사이즈
	private String pititle; //프라이빗 이슈 제목
	private String tititle; //협업공간 이슈 제목
	private String picontent; //프라이빗 이슈 내용
	private String ticontent; //협업공간 이슈 내용
	private Timestamp pistart; //프라이빗 일정 시작
	private Timestamp piend; //프라이빗 일정 끝
	private Timestamp tistart; //협업공간 일정 시작
	private Timestamp tiend; //협업공간 일정 끝
	private int ispibook; //프라이빗 북마크 여부
	private int istbook; //협업공간 북마크 여부
	private String email; //글쓴이
	private Timestamp pidate; //프라이빗 이슈 작성 시간
	private Timestamp tidate; //협업공간 이슈 작성 시간
	private String mygfilename; //프라이빗 구글 파일 이름
	private String tgfilename; //협업공간 구글 파일 이름
	private String mymention; //프라이빗 멘션
	private String myurl; //프라이빗 url
	private String turl; //협업공간 url
	private String pname; //협업공간 이름
	private MultipartFile[] files; //첨부 파일들
	private String tfilename; //협업공간 파일 이름
	private String tfilesize; //협업공간 파일 사이즈
	private int isprocess; //진행상황
	private int issee; //읽음 여부
	private String backgroundColor; //이슈 캘린더 백그라운드 색상
	private String textColor; //이슈 캘린더 글색상
	private int allDay; //하루종일 체크 여부
	
	
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
	public int getAllDay() {
		return allDay;
	}
	public void setAllDay(int allDay) {
		this.allDay = allDay;
	}
	public int getTseq() {
		return tseq;
	}
	public void setTseq(int tseq) {
		this.tseq = tseq;
	}
	public int getPiseq() {
		return piseq;
	}
	public void setPiseq(int piseq) {
		this.piseq = piseq;
	}
	public int getTiseq() {
		return tiseq;
	}
	public void setTiseq(int tiseq) {
		this.tiseq = tiseq;
	}
	public String getPfilename() {
		return pfilename;
	}
	public void setPfilename(String pfilename) {
		this.pfilename = pfilename;
	}
	public String getPfilesize() {
		return pfilesize;
	}
	public void setPfilesize(String pfilesize) {
		this.pfilesize = pfilesize;
	}
	public String getPititle() {
		return pititle;
	}
	public void setPititle(String pititle) {
		this.pititle = pititle;
	}
	public String getTititle() {
		return tititle;
	}
	public void setTititle(String tititle) {
		this.tititle = tititle;
	}
	public String getPicontent() {
		return picontent;
	}
	public void setPicontent(String picontent) {
		this.picontent = picontent;
	}
	public String getTicontent() {
		return ticontent;
	}
	public void setTicontent(String ticontent) {
		this.ticontent = ticontent;
	}
	public Timestamp getPistart() {
		return pistart;
	}
	public void setPistart(Timestamp pistart) {
		this.pistart = pistart;
	}
	public Timestamp getPiend() {
		return piend;
	}
	public void setPiend(Timestamp piend) {
		this.piend = piend;
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
	public int getIspibook() {
		return ispibook;
	}
	public void setIspibook(int ispibook) {
		this.ispibook = ispibook;
	}
	public int getIstbook() {
		return istbook;
	}
	public void setIstbook(int istbook) {
		this.istbook = istbook;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getPidate() {
		return pidate;
	}
	public void setPidate(Timestamp pidate) {
		this.pidate = pidate;
	}
	public Timestamp getTidate() {
		return tidate;
	}
	public void setTidate(Timestamp tidate) {
		this.tidate = tidate;
	}
	public String getMygfilename() {
		return mygfilename;
	}
	public void setMygfilename(String mygfilename) {
		this.mygfilename = mygfilename;
	}
	public String getTgfilename() {
		return tgfilename;
	}
	public void setTgfilename(String tgfilename) {
		this.tgfilename = tgfilename;
	}
	public String getMymention() {
		return mymention;
	}
	public void setMymention(String mymention) {
		this.mymention = mymention;
	}
	public String getMyurl() {
		return myurl;
	}
	public void setMyurl(String myurl) {
		this.myurl = myurl;
	}
	public String getTurl() {
		return turl;
	}
	public void setTurl(String turl) {
		this.turl = turl;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public MultipartFile[] getFiles() {
		return files;
	}
	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}
	public String getTfilename() {
		return tfilename;
	}
	public void setTfilename(String tfilename) {
		this.tfilename = tfilename;
	}
	public String getTfilesize() {
		return tfilesize;
	}
	public void setTfilesize(String tfilesize) {
		this.tfilesize = tfilesize;
	}
	public int getIsprocess() {
		return isprocess;
	}
	public void setIsprocess(int isprocess) {
		this.isprocess = isprocess;
	}
	public int getIssee() {
		return issee;
	}
	public void setIssee(int issee) {
		this.issee = issee;
	}
	@Override
	public String toString() {
		return "MyIssue [tseq=" + tseq + ", piseq=" + piseq + ", tiseq=" + tiseq + ", pfilename=" + pfilename
				+ ", pfilesize=" + pfilesize + ", pititle=" + pititle + ", tititle=" + tititle + ", picontent="
				+ picontent + ", ticontent=" + ticontent + ", pistart=" + pistart + ", piend=" + piend + ", tistart="
				+ tistart + ", tiend=" + tiend + ", ispibook=" + ispibook + ", istbook=" + istbook + ", email=" + email
				+ ", pidate=" + pidate + ", tidate=" + tidate + ", mygfilename=" + mygfilename + ", tgfilename="
				+ tgfilename + ", mymention=" + mymention + ", myurl=" + myurl + ", turl=" + turl + ", pname=" + pname
				+ ", files=" + Arrays.toString(files) + ", tfilename=" + tfilename + ", tfilesize=" + tfilesize
				+ ", isprocess=" + isprocess + ", issee=" + issee + ", backgroundColor=" + backgroundColor
				+ ", textColor=" + textColor + ", allDay=" + allDay + "]";
	}


	
}
