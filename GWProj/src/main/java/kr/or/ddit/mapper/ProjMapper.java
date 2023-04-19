package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BookmarkVO;
import kr.or.ddit.vo.ChkVO;
import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.ProjVO;
import kr.or.ddit.vo.PrtpntVO;
import kr.or.ddit.vo.TaskCountVO;
import kr.or.ddit.vo.TaskVO;

public interface ProjMapper {

	//프로젝트 전체 목록
	public List<ProjVO> projList(String username);

	//프로젝트 등록
	public int createPost(ProjVO projVO);
	public int createPost1(ProjVO projVO);
	public int createPost2(ProjVO projVO);

	//프로젝트 즐겨찾기 등록
	public int createBookmark(BookmarkVO bookmarkVO);

	//프로젝트 즐겨찾기 삭제
	public int deleteBookmark(BookmarkVO bookmarkVO);

	//프로젝트 상세 정보
	public ProjVO projDetail(ProjVO projVO);

	//프로젝트 상세 화면에 띄울 태스크 상세정보
	public ProjVO projTaskDetail(String projNo);

	//프로젝트 참여자 목록
	public List<PrtpntVO> prtList(PrtpntVO prtpntVO);

	//태스크 등록
	public int taskCreate(TaskVO taskVO);
	public int taskMake(TaskVO taskVO);
	public int taskPrt(TaskVO taskVO);

	//프로젝트 삭제
	public int projDelete(ProjVO projVO);
	public int projDelete1(ProjVO projVO);
	public int projDelete2(ProjVO projVO);

	//프로젝트 복구
	public int remake(ProjVO projVO);

	//진행중인 태스크의 개수
	public int ingTask(ProjVO projVO);

	//태스크 수 통계
	public TaskCountVO taskCount(ProjVO projVO);

	//전체 사원의 목록
	public List<ProjVO> empList();

	//프로젝트 참여자 등록
	public int projPrtAdd(PrtpntVO prtpntVO);

	//태스크 상세 정보
	public TaskVO taskDetail(TaskVO taskVO);

	//체크리스트 체크
	public int chkY(ChkVO chkVO);

	//체크리스트 체크 해제
	public int chkN(ChkVO chkVO);

	//체크리스트 등록
	public int addChkList(ChkVO chkVO);

	//체크리스트 삭제
	public int delChkList(ChkVO chkVO);

	//댓글 등록
	public int createCmnt(CmntVO cmntVO);

	//댓글 삭제
	public int delCmntList(CmntVO cmntVO);

	//댓글 삭제
	public int updateCmnt(CmntVO cmntVO);

	//태스크 상태 변경
	public int updateSsts(TaskVO taskVO);

	//태스크 설명 추가
	public int createExp(TaskVO taskVO);

	//태스크 라벨 등록
	public int createLabel(TaskVO taskVO);

	//파일 업로드 후 파일그룹번호 업데이트
	public void taskUpdate(TaskVO taskVO);

	//파일 삭제
	public int deleteFile(FilesVO filesVO);

	//메인페이지 프로젝트 목록
	public List<ProjVO> mainProjList(EmpVO empVO);


}
