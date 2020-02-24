package kr.or.scoop.dto;

import java.sql.Timestamp;
//프라이빗 파일함
public class PrivateFileDrive {
	private int pdseq; //프라이빗 파일 번호
	private int pdcapa; //프라이빗 파일 사이즈
	private String pfdname; //프라이빗 파일 이름
	private Timestamp pfddate; //프라이빗 파일 올린 시간
	private String email; //프라이빗 파일 올린 사람 이메일
	private int piseq; //프라이빗 이슈 번호
	public int getPdseq() {
		return pdseq;
	}
	public void setPdseq(int pdseq) {
		this.pdseq = pdseq;
	}
	public int getPdcapa() {
		return pdcapa;
	}
	public void setPdcapa(int pdcapa) {
		this.pdcapa = pdcapa;
	}
	public String getPfdname() {
		return pfdname;
	}
	public void setPfdname(String pfdname) {
		this.pfdname = pfdname;
	}
	public Timestamp getPfddate() {
		return pfddate;
	}
	public void setPfddate(Timestamp pfddate) {
		this.pfddate = pfddate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPiseq() {
		return piseq;
	}
	public void setPiseq(int piseq) {
		this.piseq = piseq;
	}
	@Override
	public String toString() {
		return "FileDrive [pdseq=" + pdseq + ", pdcapa=" + pdcapa + ", pfdname=" + pfdname + ", pfddate=" + pfddate
				+ ", email=" + email + ", piseq=" + piseq + "]";
	}

}
