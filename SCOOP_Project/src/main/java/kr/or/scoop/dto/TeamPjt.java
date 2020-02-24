package kr.or.scoop.dto;



import java.sql.Date;

import org.springframework.stereotype.Repository;

@Repository
public class TeamPjt {
	private int tseq; 		//프로젝트 번호 
	private String email;  	//팀장이메일 
	private String pname; 	//프로젝트 이름
	private String pcontent;//프로젝트 설명
	private Date ptime;  	//프로젝트 생성 날짜
	private int istpalarm; 	//알림 여부
	private int ischarge; 	//유료 여부
	
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
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public Date getPtime() {
		return ptime;
	}
	public void setPtime(Date ptime) {
		this.ptime = ptime;
	}
	public int getIstpalarm() {
		return istpalarm;
	}
	public void setIstpalarm(int istpalarm) {
		this.istpalarm = istpalarm;
	}
	public int getIscharge() {
		return ischarge;
	}
	public void setIscharge(int ischarge) {
		this.ischarge = ischarge;
	}
	
	@Override
	public String toString() {
		return "TeamPjt [tseq=" + tseq + ", email=" + email + ", pname=" + pname + ", pcontent=" + pcontent + ", ptime="
				+ ptime + ", istpalarm=" + istpalarm + ", ischarge=" + ischarge + "]";
	}
	
	
}
