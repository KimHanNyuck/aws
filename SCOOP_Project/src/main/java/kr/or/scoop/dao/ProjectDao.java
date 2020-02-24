package kr.or.scoop.dao;

import java.util.List;

import kr.or.scoop.dto.PjNotice;
import kr.or.scoop.dto.Role;
import kr.or.scoop.dto.TeamPjt;
import kr.or.scoop.dto.Tissue;
import kr.or.scoop.dto.Tpmember;

public interface ProjectDao {
	//협업공간 생성
	public int insertPJT(TeamPjt team);
	
	//협업공간 멤버 초대 성공
	public int insertPJT2(String email, int tseq);
	
	//프로젝트 리스트 
	public List<Tpmember> getPJT(String email);
	
	//프로젝트 디테일
	public TeamPjt detailPJT(int tseq);
	
	//팀이슈 리스트
	public List<Tissue> getTissue(int tseq); 
	
	//프로젝트 수정
	public int updatePjt(TeamPjt teampjt);
	
	//팀 권한 조회
	public int searchRank(int tseq, String email);

	//북마크 추가
	public int addBookMark(int tiseq, String email);
	
	//북마크 삭제
	public int delBookMark(int tiseq, String email);
	
	//북마크 조회
	public int seachBookMark(int tseq);
	
	//프로젝트 공지사항 리스트
	public List<PjNotice> getPjNotice(int tseq);
	
	//프로젝트 공지사항 작성
	public int pjNoticeWrite(PjNotice pjnotice);
	
	//프로젝트 공지사항 상세보기
	public PjNotice pjNoticeDetail(int pnseq);
	
	//프로젝트 공지사항 수정
	public int updatePjNotice(PjNotice pjnotice);
	
	//프로젝트 공지사항 삭제
	public int deletePjNotice(int pnseq);
	
	//프로젝트 멤버 리스트
	public List<Tpmember> getTpMember(String email);
	
	//프로젝트 공지사항 권한
	public int searchNoticeRank(int pnseq, String email,int tseq);
	
	//프로젝트 갯수 세기
	public int getCountProject(String email);
	
	//멤버 롤 검색
	public Role getUserRole(String email);
}
