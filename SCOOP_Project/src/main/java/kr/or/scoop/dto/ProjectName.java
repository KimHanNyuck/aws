package kr.or.scoop.dto;
//협업공간 이름
public class ProjectName {
	private int tseq; //협업공간 번호
	private int tiseq; //협업공간 이슈 번호
	private String pname; //협업공간 이름
	
	public int getTseq() {
		return tseq;
	}
	public void setTseq(int tseq) {
		this.tseq = tseq;
	}
	public int getTiseq() {
		return tiseq;
	}
	public void setTiseq(int tiseq) {
		this.tiseq = tiseq;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	
	@Override
	public String toString() {
		return "ProjectName [tseq=" + tseq + ", tiseq=" + tiseq + ", pname=" + pname + "]";
	}
}
