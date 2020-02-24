package kr.or.scoop.dto;
//알람
public class Alarm {
	private String pnaemail;
	private String pnatitle;
	private int ispna;
	private int pnseq;
	
	private String raemail;
	private String ratitle;
	private int isra;
	private int replyseq;
	
	@Override
	public String toString() {
		return "Alarm [pnaemail=" + pnaemail + ", pnatitle=" + pnatitle + ", ispna=" + ispna + ", pnseq=" + pnseq
				+ ", raemail=" + raemail + ", ratitle=" + ratitle + ", isra=" + isra + ", replyseq=" + replyseq
				+ ", tiatitle=" + tiatitle + ", istia=" + istia + ", tiaemail=" + tiaemail + ", tiseq=" + tiseq
				+ ", vaemail=" + vaemail + ", vatitle=" + vatitle + ", isva=" + isva + ", vseq=" + vseq + "]";
	}
	public String getPnaemail() {
		return pnaemail;
	}
	public void setPnaemail(String pnaemail) {
		this.pnaemail = pnaemail;
	}
	public String getPnatitle() {
		return pnatitle;
	}
	public void setPnatitle(String pnatitle) {
		this.pnatitle = pnatitle;
	}
	public int getIspna() {
		return ispna;
	}
	public void setIspna(int ispna) {
		this.ispna = ispna;
	}
	public int getPnseq() {
		return pnseq;
	}
	public void setPnseq(int pnseq) {
		this.pnseq = pnseq;
	}
	public String getRaemail() {
		return raemail;
	}
	public void setRaemail(String raemail) {
		this.raemail = raemail;
	}
	public String getRatitle() {
		return ratitle;
	}
	public void setRatitle(String ratitle) {
		this.ratitle = ratitle;
	}
	public int getIsra() {
		return isra;
	}
	public void setIsra(int isra) {
		this.isra = isra;
	}
	public int getReplyseq() {
		return replyseq;
	}
	public void setReplyseq(int replyseq) {
		this.replyseq = replyseq;
	}
	public String getTiatitle() {
		return tiatitle;
	}
	public void setTiatitle(String tiatitle) {
		this.tiatitle = tiatitle;
	}
	public int getIstia() {
		return istia;
	}
	public void setIstia(int istia) {
		this.istia = istia;
	}
	public String getTiaemail() {
		return tiaemail;
	}
	public void setTiaemail(String tiaemail) {
		this.tiaemail = tiaemail;
	}
	public int getTiseq() {
		return tiseq;
	}
	public void setTiseq(int tiseq) {
		this.tiseq = tiseq;
	}
	public String getVaemail() {
		return vaemail;
	}
	public void setVaemail(String vaemail) {
		this.vaemail = vaemail;
	}
	public String getVatitle() {
		return vatitle;
	}
	public void setVatitle(String vatitle) {
		this.vatitle = vatitle;
	}
	public int getIsva() {
		return isva;
	}
	public void setIsva(int isva) {
		this.isva = isva;
	}
	public int getVseq() {
		return vseq;
	}
	public void setVseq(int vseq) {
		this.vseq = vseq;
	}
	private String tiatitle;
	private int istia;
	private String tiaemail;
	private int tiseq;
	
	private String vaemail;
	private String vatitle;
	private int isva;
	private int vseq;
	

}
