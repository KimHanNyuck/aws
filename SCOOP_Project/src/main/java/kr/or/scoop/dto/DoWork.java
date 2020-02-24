package kr.or.scoop.dto;

import java.sql.Timestamp;

//할일
public class DoWork {
 private String fromname; //보낸사람
 private String toname; //받는사람
 private String dowork; //협업공간 할일내용
 private String pdowork; //프라이빗 할일내용
 private String toemail; //보낸사람 이메일
 private int tdseq; //협업공간 할일 번호
 private String ptoemail; //받는사람 이메일
 private int pwseq; //프라이빗 할일 번호
 private String pname; //협업공간 이름
 private String tititle; //협업공간 이슈 제목
 private Timestamp tidate; //협업공간 이슈 작성시간
 private int tseq; //협업공간 번호
 private String name; //멘션 남긴사람 이름
 private int tiseq; //협업공간 이슈 번호
public String getFromname() {
	return fromname;
}
public void setFromname(String fromname) {
	this.fromname = fromname;
}
public String getToname() {
	return toname;
}
public void setToname(String toname) {
	this.toname = toname;
}
public String getDowork() {
	return dowork;
}
public void setDowork(String dowork) {
	this.dowork = dowork;
}
public String getPdowork() {
	return pdowork;
}
public void setPdowork(String pdowork) {
	this.pdowork = pdowork;
}
public String getToemail() {
	return toemail;
}
public void setToemail(String toemail) {
	this.toemail = toemail;
}
public int getTdseq() {
	return tdseq;
}
public void setTdseq(int tdseq) {
	this.tdseq = tdseq;
}
public String getPtoemail() {
	return ptoemail;
}
public void setPtoemail(String ptoemail) {
	this.ptoemail = ptoemail;
}
public int getPwseq() {
	return pwseq;
}
public void setPwseq(int pwseq) {
	this.pwseq = pwseq;
}
public String getPname() {
	return pname;
}
public void setPname(String pname) {
	this.pname = pname;
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
public int getTseq() {
	return tseq;
}
public void setTseq(int tseq) {
	this.tseq = tseq;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getTiseq() {
	return tiseq;
}
public void setTiseq(int tiseq) {
	this.tiseq = tiseq;
}
@Override
public String toString() {
	return "DoWork [fromname=" + fromname + ", toname=" + toname + ", dowork=" + dowork + ", pdowork=" + pdowork
			+ ", toemail=" + toemail + ", tdseq=" + tdseq + ", ptoemail=" + ptoemail + ", pwseq=" + pwseq + ", pname="
			+ pname + ", tititle=" + tititle + ", tidate=" + tidate + ", tseq=" + tseq + ", name=" + name + ", tiseq="
			+ tiseq + "]";
}
 
}
