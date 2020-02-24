package kr.or.scoop.dto;

import java.sql.Timestamp;
//멘션
public class Mention {
	private int tiseq; //협업공간 이슈 번호
	private int tmseq; //협업공간 이슈 멘션 번호
	private String email; //협업공간 이슈 멘션 된 사람 이메일
	private String name;  //협업공간 이슈 멘션 된 사람 이름
	private int pmseq; //프라이빗 이슈 멘션 번호
	private String pemail; //프라이빗 이슈 멘션 된 사람 이메
	private int piseq; //프라이빗 이슈 번호
	private String pname; //협업공간 이름
	private int tseq; //협업공간 번호
	private String tititle; //협업공간 이슈 내용
	private Timestamp tidate; //협업공간 이슈 작성 시간
	public int getTiseq() {
		return tiseq;
	}
	public void setTiseq(int tiseq) {
		this.tiseq = tiseq;
	}
	public int getTmseq() {
		return tmseq;
	}
	public void setTmseq(int tmseq) {
		this.tmseq = tmseq;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPmseq() {
		return pmseq;
	}
	public void setPmseq(int pmseq) {
		this.pmseq = pmseq;
	}
	public String getPemail() {
		return pemail;
	}
	public void setPemail(String pemail) {
		this.pemail = pemail;
	}
	public int getPiseq() {
		return piseq;
	}
	public void setPiseq(int piseq) {
		this.piseq = piseq;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getTseq() {
		return tseq;
	}
	public void setTseq(int tseq) {
		this.tseq = tseq;
	}
	public String getTititle() {
		return tititle;
	}
	public void setTititle(String tititle) {
		this.tititle = tititle;
	}
	public Timestamp getTidate() {
		return tidate;
	}
	public void setTidate(Timestamp tidate) {
		this.tidate = tidate;
	}
	@Override
	public String toString() {
		return "Mention [tiseq=" + tiseq + ", tmseq=" + tmseq + ", email=" + email + ", name=" + name + ", pmseq="
				+ pmseq + ", pemail=" + pemail + ", piseq=" + piseq + ", pname=" + pname + ", tseq=" + tseq
				+ ", tititle=" + tititle + ", tidate=" + tidate + "]";
	}
	
}
