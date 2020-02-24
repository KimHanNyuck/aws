package kr.or.scoop.dto;

import java.sql.Timestamp;
//프로젝트 공지사항
public class PjNotice {
	private int pnseq; //협업공간 공지사항 번호
	private String pntitle; //협업공간 공지사항 제목
	private String pncontent; //협업공간 공지사항 내용
	private Timestamp pntime; //협업공간 공지사항 작성시간
	private String email; //협업공간 공지사항 글쓴이 이메일
	private int tseq; //협업공간 번호
	private String name; //협업공간 공지사항 글쓴이 이름
	private String pname; //협업공간 이름
	
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPnseq() {
		return pnseq;
	}
	public void setPnseq(int pnseq) {
		this.pnseq = pnseq;
	}
	public String getPntitle() {
		return pntitle;
	}
	public void setPntitle(String pntitle) {
		this.pntitle = pntitle;
	}
	public String getPncontent() {
		return pncontent;
	}
	public void setPncontent(String pncontent) {
		this.pncontent = pncontent;
	}
	
	public Timestamp getPntime() {
		return pntime;
	}
	public void setPntime(Timestamp pntime) {
		this.pntime = pntime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getTseq() {
		return tseq;
	}
	public void setTseq(int tseq) {
		this.tseq = tseq;
	}
	
	@Override
	public String toString() {
		return "PjNotice [pnseq=" + pnseq + ", pntitle=" + pntitle + ", pncontent=" + pncontent + ", pntime=" + pntime
				+ ", email=" + email + ", tseq=" + tseq + ", name=" + name + ", pname=" + pname + "]";
	}

}
