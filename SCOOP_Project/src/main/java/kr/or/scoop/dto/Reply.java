package kr.or.scoop.dto;


import org.springframework.stereotype.Repository;

@Repository
public class Reply {
	
	private int replyseq; //댓글 번호 
	private String rcontent; //댓글 내용
	private String email; //댓글 작성자 이메일
	private String rdate; //댓글 생성 날짜및시간
	private int tiseq; //팀이슈 번호 
	private String name; //댓글 작성자 이름
	private String tititle; //팀이슈제목
	private String profile; //댓글 작성자 이미지 이름
	public int getReplyseq() {
		return replyseq;
	}
	public void setReplyseq(int replyseq) {
		this.replyseq = replyseq;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public int getTiseq() {
		return tiseq;
	}
	public void setTiseq(int tiseq) {
		this.tiseq = tiseq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTititle() {
		return tititle;
	}
	public void setTititle(String tititle) {
		this.tititle = tititle;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	@Override
	public String toString() {
		return "Reply [replyseq=" + replyseq + ", rcontent=" + rcontent + ", email=" + email + ", rdate=" + rdate
				+ ", tiseq=" + tiseq + ", name=" + name + ", tititle=" + tititle + ", profile=" + profile + "]";
	}
	
}
