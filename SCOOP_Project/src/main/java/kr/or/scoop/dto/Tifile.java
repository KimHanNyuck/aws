package kr.or.scoop.dto;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class Tifile {
	private int tiseq; //팀이슈 번호 
	private List<CommonsMultipartFile> files; //올린 파일들
	private String tfilename; //파일 이름
	private long tfilesize; //파일 사이즈
	public int getTiseq() {
		return tiseq;
	}
	public void setTiseq(int tiseq) {
		this.tiseq = tiseq;
	}
	public List<CommonsMultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<CommonsMultipartFile> files) {
		this.files = files;
	}
	public String getTfilename() {
		return tfilename;
	}
	public void setTfilename(String tfilename) {
		this.tfilename = tfilename;
	}
	public long getTfilesize() {
		return tfilesize;
	}
	public void setTfilesize(long tfilesize) {
		this.tfilesize = tfilesize;
	}
	
	@Override
	public String toString() {
		return "Tifile [tiseq=" + tiseq + ", files=" + files + ", tfilename=" + tfilename + ", tfilesize=" + tfilesize
				+ "]";
	}
	
	
	
	
	
}
