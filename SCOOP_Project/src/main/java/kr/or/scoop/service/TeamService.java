package kr.or.scoop.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.scoop.dao.ProjectDao;
import kr.or.scoop.dao.TissueDao;
import kr.or.scoop.dto.Link;
import kr.or.scoop.dto.PjNotice;
import kr.or.scoop.dto.Reply;
import kr.or.scoop.dto.TeamPjt;
import kr.or.scoop.dto.Tissue;

@Service
public class TeamService {
	
	@Autowired
	private SqlSession sqlsession;
	
	//칸반 리스트 내용 불러오기 
	public List<Tissue> loadKanban(int tseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		List<Tissue> tissuelist = dao.loadKanban(tseq);
		return tissuelist;
	}
	//협업공간 멤버 권한 수정 (일반 멤버, 팀장)
	public int teamSetting(int[] pjuserrank, int tseq, String[] email) {
		int result = 0 ;
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		for(int i=0; i<email.length;i++) {
			result = dao.teamSetting(pjuserrank[i], tseq, email[i]);
		}
		return result;
	}
	// 칸반 수정
	public int EditKanban(int tseq, int tiseq, int isprocess) {
		int result = 0;
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		result = dao.kanbanEdit(tseq, tiseq, isprocess);
		return result;
	}
	//협업 공간 멤버 탈퇴
	public int banMember(int tseq, String email) {
		int result = 0;
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		result = dao.banMember(tseq, email);
		return result;
	}
	//협업공간 팀장위임 --팀장변경
	public int changeManager(int tseq, String email) {
		int result = 0;
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		result = dao.changeMember(tseq, email);
		return result;
	}
	//협업공간 팀장위임 --팀장으로 등급번호 변경
	public int changeManagerTp(int tseq, String email) {
		int result = 0;
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		result = dao.changeMemberTp(tseq, email);
		return result;
	}
	//협업공간 팀장위임 --일반 멤버로 등급번호 변경
	public int changeManagerTp2(int tseq, String email) {
		int result = 0;
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		result = dao.changeMemberTp2(tseq, email);
		return result;
	}
	//협업공간 삭제하기
	public int dropProject(int tseq) {
		int result = 0;
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		result = dao.dropProject(tseq);
		return result;
	}
	//프로젝트 수정
	public int teamUpdate(TeamPjt teampjt) {
		int result = 0;
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		result = dao.updatePjt(teampjt);
		return result;
	}
	
	//팀 프로젝트 댓글 입력
	public int teamComment(int tiseq,String rcontent,String email) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.teamComment(tiseq,rcontent,email);
		return result;
	}
	//팀 댓글 비동기 뿌려주기 
	public List<Reply> teamCommentOk(int tiseq){
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		List<Reply> result = dao.teamCommentOk(tiseq);
		return result;
	}
	//팀이슈 댓글 삭제
	public int delComment(int replyseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.delComment(replyseq);
		return result;
	}
	
	//팀 파일 업로드
	public int fileInsert(int tseq, String fdname, long fdcapa, String email) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.fileInsert(tseq, fdname, fdcapa, email);
		return result;
	}
	//팀 파일 업로드
	public int fileEdit(int tseq, String fdname, long fdcapa, String email, int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.fileEdit(tseq, fdname, fdcapa, email, tiseq);
		return result;
	}
	//협업공간 이슈 파일 삭제
	public int fileDelete(int fdseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.fileDelete(fdseq);
		return result;
	}
	//협업공간 이슈 수정화면에서 원래 있던 파일들의 사이즈 가져오기
	public List<Long> getOriFilesize(int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		List<Long> result = dao.getOriFilesize(tiseq);
		return result;
	}
	//나의이슈 수정화면에서 원래 있던 파일들의 사이즈 가져오기
	public List<Long> getMyOriFilesize(int piseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		List<Long> result = dao.getMyOriFilesize(piseq);
		return result;
	}
	
	//개인 파일 업로드
	public int myFileInsert(String pfdname, long pdcapa, String email) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.myFileInsert(pfdname, pdcapa, email);
		
		return result;
	}
	
	//프로젝트 공지사항 작성
	public int pjNoticeWrite(PjNotice pjnotice) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		int result = dao.pjNoticeWrite(pjnotice);
		
		return result;
	}
	
	//팀 멘션 생성
	public int mentionInsert(String email) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.mentionInsert(email);
		return result;
	}
	//팀 멘션 수정
	public int mentionEdit(String email, int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.mentionEdit(email, tiseq);
		return result;
	}
	//팀 멘션 삭제
	public int mentionDelete(int tmseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.mentionDelete(tmseq);
		return result;
	}
	
	//나의 멘션 생성
	public int myMentionInsert(String email) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.myMentionInsert(email);
		return result;
	}
	//팀 구글드라이브 생성
	public int googleDriveInsert(String gfilename, String gurl) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.googleDriveInsert(gfilename, gurl);
		return result;
	}
	//팀 구글드라이브 수정
	public int googleDriveEdit(String gfilename, String gurl, int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.googleDriveEdit(gfilename, gurl, tiseq);
		return result;
	}
	//팀 구글드라이브 삭제
	public int googleDriveDelete(int tgseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.googleDriveDelete(tgseq);
		return result;
	}
	//개인 구글드라이브 생성
	public int myGoogleDriveInsert(String pgfilename,String pgurl) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.myGoogleDriveInsert(pgfilename, pgurl);
		return result;
	}
	//팀 할일 생성
	public int doWorkInsert(String fromWork, String toWork, String doWork) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.doWorkInsert(fromWork, toWork, doWork);
		return result;
	}
	//팀 할일 수정
	public int doWorkEdit(String fromWork, String toWork, String doWork, int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.doWorkEdit(fromWork, toWork, doWork, tiseq);
		return result;
	}
	//팀 할일 제거
	public int doWorkDelete(int tdseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.doWorkDelete(tdseq);
		return result;
	}
	//개인 할일 생성
	public int myDoWorkInsert(String fromWork, String toWork, String doWork) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.myDoWorkInsert(fromWork, toWork, doWork);
		return result;
	}
	//글작성할때 협업공간 이슈 번호 불러오기
	public int getMaxTiseq() {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.getMaxTiseq();
		return result;
	}
	//글작성할때 프라이빗 이슈 번호 불러오기
	public int getMaxMyTiseq() {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.getMaxMyTiseq();
		return result;
	}
	//프로젝트 공지사항 수정
	public int pjNoticeEdit(PjNotice pjnotice) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		int result = dao.updatePjNotice(pjnotice);
		return result;
	}
	//협업공간 파일 삭제
	public int teamIssueFileDelete(int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.teamIssueFileDelete(tiseq);
		return result;
	}
	//협업공간 멘션 삭제
	public int teamIssueMentionDelete(int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.teamIssueMentionDelete(tiseq);
		return result;
	}
	//협업공간 구글드라이브 삭제
	public int teamIssueGoogleDriveDelete(int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.teamIssueGoogleDriveDelete(tiseq);
		return result;
	}
	//협업공간 할일 삭제
	public int teamIssueDoWorkDelete(int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.teamIssueDoWorkDelete(tiseq);
		return result;
	}
	//협업공간 이슈 삭제
	public int teamIssueDelete(int tiseq) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.teamIssueDelete(tiseq);
		return result;
	}
	//팀 링크 추가
	public int teamLinkInsert(int tseq, String link, String email) {
		TissueDao dao = sqlsession.getMapper(TissueDao.class);
		int result = dao.teamLinkInsert(tseq, link, email);
		return result;
	}
}
