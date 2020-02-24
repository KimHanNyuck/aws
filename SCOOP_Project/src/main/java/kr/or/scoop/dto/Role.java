package kr.or.scoop.dto;

import org.springframework.stereotype.Repository;

@Repository
public class Role {
	private String email; //사용자 이메일
	private String rname; //사용자 등급
	private int count; //사용자 프로젝트 개수
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	@Override
	public String toString() {
		return "Role [email=" + email + ", rname=" + rname + ", count=" + count + "]";
	}
	
	
	
	
}
