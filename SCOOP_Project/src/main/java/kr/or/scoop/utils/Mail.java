package kr.or.scoop.utils;
//velocity 메일
public class Mail {
	private String mailTo; //받는 사람
	private String setForm; //보내는 사람
	private String title; //제목
	public String getMailTo() {
		return mailTo;
	}
	public void setMailTo(String mailTo) {
		this.mailTo = mailTo;
	}
	public String getSetForm() {
		return setForm;
	}
	public void setSetForm(String setForm) {
		this.setForm = setForm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}
