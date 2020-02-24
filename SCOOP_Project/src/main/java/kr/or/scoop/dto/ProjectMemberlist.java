package kr.or.scoop.dto;
//협업공간 멤버리스트
public class ProjectMemberlist {
	private String email; //이메일
	private String name; //이름
	private int tseq; //협업공간 번호
	private int pjuserrank; //유저 등급
	
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
	public int getTseq() {
		return tseq;
	}
	public void setTseq(int tseq) {
		this.tseq = tseq;
	}
	public int getPjuserrank() {
		return pjuserrank;
	}
	public void setPjuserrank(int pjuserrank) {
		this.pjuserrank = pjuserrank;
	}

	@Override
	public String toString() {
		return "ProjectMemberlist [email=" + email + ", name=" + name + ", tseq=" + tseq + ", pjuserrank=" + pjuserrank
				+ "]";
	}
	
	
}
