package kr.or.scoop.dao;

import java.util.List;

import kr.or.scoop.dto.DoWork;
import kr.or.scoop.dto.FileDrive;
import kr.or.scoop.dto.GoogleDrive;
import kr.or.scoop.dto.Link;
import kr.or.scoop.dto.Mention;
import kr.or.scoop.dto.MyIssue;
import kr.or.scoop.dto.Process;
import kr.or.scoop.dto.Reply;
import kr.or.scoop.dto.Tissue;

public interface TissueDao {
	
	//칸반 불러오기
	public List<Tissue> loadKanban(int tseq);
	
	//협업공간 멤버 권한 수정
	public int teamSetting(int pjuserrank, int tseq, String email);
	
	//협업공간 칸반 수정
	public int kanbanEdit(int tseq, int tiseq, int isprocess);
	
	//협업공간 멤버탈퇴	
	public int banMember(int tseq, String email);
	
	//협업공간 팀장위임
	public int changeMember(int tseq, String email); //팀장변경
	public int changeMemberTp(int tseq, String email);//팀장으로 등급번호 변경
	public int changeMemberTp2(int tseq, String email);//일반 멤버로 등급번호 변경
	
	//협업공간 삭제하기
	public int dropProject(int tseq);
	
	//팀 이슈 디테일
	public Tissue teamissueDetail(int tiseq);
	
	//팀이슈 댓글
	public int teamComment(int tiseq,String rcontent,String email);
	
	//팀이슈 댓글 리스트 출력
	public List<Reply> teamCommentOk(int tiseq);
	
	//팀이슈 멘션 리스트 출력
	public List<Mention> getMentions(int tiseq);
	
	//팀이슈 구글드라이브 출력
	public List<GoogleDrive> getGoogleDrive(int tiseq);

	//팀이슈 할일 출력
	public List<DoWork> getDoWork(int tiseq);
	
	//팀이슈 파일 출력
	public List<FileDrive> getFiles(int tiseq);
	
	//팀이슈 댓글 삭제
	public int delComment(int replyseq);
	
	//북마크 추가
	public int addTBookMark(int tiseq, String email);
	
	//북마크 제거
	public int delTBookMark(int tiseq, String email);
	
	//협업공간 이슈 파일 추가
	public int fileInsert(int tseq, String fdname, long fdcapa, String email);
	
	//협업공간 이슈 파일 수정
	public int fileEdit(int tseq, String fdname, long fdcapa, String email, int tiseq);
	
	//나의 이슈 파일 추가
	public int myFileInsert(String pfdname, long pdcapa, String email);
	
	//협업공간 이슈 파일 삭제
	public int fileDelete(int fdseq);
	
	//협업공간 이슈 멘션 추가
	public int mentionInsert(String email);
	
	//협업공간 이슈 멘션 수정
	public int mentionEdit(String email, int tiseq);
	
	//협업공간 이슈 멘션 추가
	public int mentionDelete(int tmseq);
	
	//나의 이슈 멘션 추가
	public int myMentionInsert(String email);
	
	//협업공간 구글드라이브 추가
	public int googleDriveInsert(String tgfilename, String tgurl);
	
	//협업공간 구글드라이브 수정
	public int googleDriveEdit(String tgfilename, String tgurl, int tiseq);
	
	//협업공간 구글드라이브 삭제
	public int googleDriveDelete(int tgseq);
	
	//나의 구글드라이브 추가
	public int myGoogleDriveInsert(String pgfilename,String pgurl);
	
	//협업공간 할일 추가
	public int doWorkInsert(String email, String toEmail, String doWork);
	
	//협업공간 할일 수정
	public int doWorkEdit(String email, String toEmail, String doWork, int tiseq);
	
	//협업공간 할일 삭제
	public int doWorkDelete(int tdseq);
	
	//나의 할일 추가
	public int myDoWorkInsert(String email, String ptoEmail, String pdoWork);

	//글작성할때 협업공간 이슈 번호 불러오기
	public int getMaxTiseq();
	
	//글작성할때 프라이빗 이슈 번호 불러오기
	public int getMaxMyTiseq();
	
	//대시보드 차트 불러오기
	public List chartData(int tseq, int isprocess);
	
	//협업공간 이슈 수정화면에서 원래 있던 파일들의 사이즈 가져오기
	public List<Long> getOriFilesize(int tiseq);
	
	//나의이슈 수정화면에서 원래 있던 파일들의 사이즈 가져오기
	public List<Long> getMyOriFilesize(int piseq);
	
	//칸반 게시글 상태 정보
	public Process chartData(int tseq);
	
	//팀이슈 리스트 받아오기
	public List<Tissue> getTissueList(int tseq);
	
	//협업공간 파일 삭제
	public int teamIssueFileDelete(int tiseq);
	
	//협업공간 멘션 삭제
	public int teamIssueMentionDelete(int tiseq);
	
	//협업공간 구글드라이브 삭제
	public int teamIssueGoogleDriveDelete(int tiseq);
	
	//협업공간 할일 삭제
	public int teamIssueDoWorkDelete(int tiseq);
	
	//협업공간 이슈 삭제
	public int teamIssueDelete(int tiseq);
	
	//팀 링크 추가
	public int teamLinkInsert(int tseq, String link, String email);
	
	//팀 링크 리스트
	public List<Link> getTLink(int tseq);
}
