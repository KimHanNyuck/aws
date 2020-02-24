package kr.or.scoop.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.scoop.dao.MyIssueDao;
import kr.or.scoop.dto.MyIssue;

@Service
public class PrivateService {
	
	@Autowired
	private SqlSession sqlsession;
	
	//팀 이슈 작성
	public int writeTissue(MyIssue tissue) {
		int result = 0 ;
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		result = dao.writeTissue(tissue);
		return result;
	}
	//마이 이슈 작성
	public int writeMyissue(MyIssue myissue) {
		int result = 0 ;
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		result = dao.writeMyissue(myissue);
		return result;
	}
	
	//팀 이슈 수정
	public int editTissue(MyIssue tissue) {
		int result = 0 ;
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		result = dao.editTissue(tissue);
		return result;
	}
	//마이 이슈 수정 
	public int editMyissue(MyIssue myissue) {
		int result = 0 ;
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		result = dao.editMyissue(myissue);
		return result;
	}
	//마이파일 수정
	public int pfileEdit(String pfdname, long pdcapa, String email, int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.pfileEdit(pfdname, pdcapa, email, piseq);
		return result;
	}
	//마이파일 삭제
	public int pfileDelete(int pdseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.pfileDelete(pdseq);
		return result;
	}
	//마이 멘션 삭제
	public int pmentionDelete(int pmseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.pmentionDelete(pmseq);
		return result;
	}
	//마이 멘션 수정
	public int pmentionEdit(String email, int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.pmentionEdit(email, piseq);
		return result;
	}
	//마이 구글드라이브 삭제
	public int pgoogleDriveDelete(int pgseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.pgoogleDriveDelete(pgseq);
		return result;
	}
	//마이 구글드라이브 수정
	public int pgoogleDriveEdit(String pgfilename, String pgurl, int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.pgoogleDriveEdit(pgfilename, pgurl, piseq);
		return result;
	}
	//팀 할일 제거
	public int pdoWorkDelete(int pwseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.pdoWorkDelete(pwseq);
		return result;
	}
	//팀 할일 수정
	public int pdoWorkEdit(String fromWork, String toWork, String pdoWork, int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.pdoWorkEdit(fromWork, toWork, pdoWork, piseq);
		return result;
	}
	//마이 이슈 파일 삭제 
	public int myIssueFileDelete(int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.myIssueFileDelete(piseq);
		return result;
	}
	//마이 이슈 멘션 삭제 
	public int myIssueMentionDelete(int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.myIssueMentionDelete(piseq);
		return result;
	}
	//마이 이슈 구글 드라이브 파일 삭제 
	public int myIssueGoogleDriveDelete(int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.myIssueGoogleDriveDelete(piseq);
		return result;
	}
	//마이 이슈 할일 삭제 
	public int myIssueDoWorkDelete(int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.myIssueDoWorkDelete(piseq);
		return result;
	}
	//마이 이슈 삭제
	public int myIssueDelete(int piseq) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.myIssueDelete(piseq);
		return result;
	}
	//마이 링크 추가
	public int myLinkInsert(String link, String email) {
		MyIssueDao dao = sqlsession.getMapper(MyIssueDao.class);
		int result = dao.myLinkInsert(link, email);
		return result;
	}
}
