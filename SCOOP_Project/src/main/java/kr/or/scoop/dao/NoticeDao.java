package kr.or.scoop.dao;

import java.util.List;

import kr.or.scoop.dto.MyIssue;
import kr.or.scoop.dto.Notice;

public interface NoticeDao {
	
	//공지사항 리스트 
	public List<Notice> getNotice();
	
	//공지사항 작성
	public int insertNotice(Notice notice);
	
	//공지사항 디테일
	public Notice detailNotice(int bnseq);
	
	//공지사항 수정
	public int updateNotice(Notice notice);
	
	//팀이슈 검색
	public List<MyIssue> searchTeamIssue(String email, String word);
	
	//마이이슈 검색
	public List<MyIssue> searchMyIssue(String email, String word);
	
	//공지사항 삭제
	public int deleteNotice(int bnseq);
}	
