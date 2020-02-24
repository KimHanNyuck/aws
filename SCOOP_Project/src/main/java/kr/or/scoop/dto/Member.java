package kr.or.scoop.dto;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
//멤버
@Repository
public class Member {
	private String email; //이메일
	private String pwd; //비밀번호
	private String name; //이름
	private CommonsMultipartFile filesrc; //프로필사진
	private String dname; //부서이름
	private String drank; //부서직함
	private String address; //주소
	private Timestamp idtime; //가입 시간
	private int loginnum; //로그인 횟수
	private String profile; //프로필 사진 파일 이름
	private int isalarm; //알람여부 
	
	public void setIdtime(Timestamp idtime) {
		this.idtime = idtime;
	}

	 

	public Timestamp getIdtime() {
		return idtime;
	}



	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getDrank() {
		return drank;
	}
	public void setDrank(String drank) {
		this.drank = drank;
	}
	
	public int getLoginnum() {
		return loginnum;
	}
	public void setLoginnum(int loginnum) {
		this.loginnum = loginnum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public CommonsMultipartFile getFilesrc() {
		return filesrc;
	}
	public void setFilesrc(CommonsMultipartFile filesrc) {
		this.filesrc = filesrc;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}



	public int getIsalarm() {
		return isalarm;
	}



	public void setIsalarm(int isalarm) {
		this.isalarm = isalarm;
	}



	@Override
	public String toString() {
		return "Member [email=" + email + ", pwd=" + pwd + ", name=" + name + ", filesrc=" + filesrc + ", dname="
				+ dname + ", drank=" + drank + ", address=" + address + ", idtime=" + idtime + ", loginnum=" + loginnum
				+ ", profile=" + profile + ", isalarm=" + isalarm + ", getIdtime()=" + getIdtime() + ", getEmail()="
				+ getEmail() + ", getPwd()=" + getPwd() + ", getName()=" + getName() + ", getDname()=" + getDname()
				+ ", getDrank()=" + getDrank() + ", getLoginnum()=" + getLoginnum() + ", getAddress()=" + getAddress()
				+ ", getFilesrc()=" + getFilesrc() + ", getProfile()=" + getProfile() + ", getIsalarm()=" + getIsalarm()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}




	
	
}
