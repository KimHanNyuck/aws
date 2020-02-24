package kr.or.scoop.dto;

public class Link {
	private int tlinkseq;
	private int mylinkseq;
	private int tseq;
	private String pname;
	private String plink;
	private String tlink;
	
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getTlinkseq() {
		return tlinkseq;
	}
	public void setTlinkseq(int tlinkseq) {
		this.tlinkseq = tlinkseq;
	}
	public int getMylinkseq() {
		return mylinkseq;
	}
	public void setMylinkseq(int mylinkseq) {
		this.mylinkseq = mylinkseq;
	}
	public int getTseq() {
		return tseq;
	}
	public void setTseq(int tseq) {
		this.tseq = tseq;
	}
	public String getPlink() {
		return plink;
	}
	public void setPlink(String plink) {
		this.plink = plink;
	}
	public String getTlink() {
		return tlink;
	}
	public void setTlink(String tlink) {
		this.tlink = tlink;
	}
	
	@Override
	public String toString() {
		return "Link [tlinkseq=" + tlinkseq + ", mylinkseq=" + mylinkseq + ", tseq=" + tseq + ", pname=" + pname
				+ ", plink=" + plink + ", tlink=" + tlink + "]";
	}
}
