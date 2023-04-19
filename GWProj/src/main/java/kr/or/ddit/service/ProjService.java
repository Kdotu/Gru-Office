package kr.or.ddit.service;

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

public interface ProjService {

	/**
	 * @param username
	 * @return 등록된 프로젝트의 정보
	 */
	public List<ProjVO> projList(String username);

	/**
	 * @param projVO
	 * @return 프로젝트 등록
	 */
	public int createPost(ProjVO projVO);

	/**
	 * @param bookmarkVO
	 * @return 등록된 즐겨찾기의 수
	 */
	public int createBookmark(BookmarkVO bookmarkVO);

	/**
	 * @param bookmarkVO
	 * @return 삭제된 즐겨찾기의 수
	 */
	public int deleteBookmark(BookmarkVO bookmarkVO);

	/**
	 * @param projVO
	 * @return 프로젝트 상세 정보
	 */
	public ProjVO projDetail(ProjVO projVO);

	/**
	 * @param projNo
	 * @return 프로젝트 상세 화면에 띄울 태스크 상세 정보
	 */
	public ProjVO projTaskDetail(String projNo);

	/**
	 * @param prtpntVO
	 * @return 프로젝트의 참여자 목록
	 */
	public List<PrtpntVO> prtList(PrtpntVO prtpntVO);

	/**
	 * @param taskVO
	 * @return 태스크 등록
	 */
	public int taskCreate(TaskVO taskVO);

	/**
	 * @param projVO
	 * @return 삭제된 프로젝트의 수
	 */
	public int projDelete(ProjVO projVO);

	/**
	 * @param projVO
	 * @return 복구된 프로젝트의 수
	 */
	public int remake(ProjVO projVO);

	/**
	 * @param projVO
	 * @return 해당 프로젝트의 진행중인 태스크의 수
	 */
	public int ingTask(ProjVO projVO);

	/**
	 * @param projVO
	 * @return 태스크 수 목록
	 */
	public TaskCountVO taskCount(ProjVO projVO);

	/**
	 * @return 전체 사원의 목록
	 */
	public List<ProjVO> empList();

	/**
	 * @param prtpntVO
	 * @return 등록된 프로젝트 참여자의 수
	 */
	public int projPrtAdd(PrtpntVO prtpntVO);

	/**
	 * @param taskVO
	 * @return 태스크 상세 정보
	 */
	public TaskVO taskDetail(TaskVO taskVO);

	/**
	 * @param chkVO
	 * @return 체크상태가 Y가 된 행의 수
	 */
	public int chkY(ChkVO chkVO);

	/**
	 * @param chkVO
	 * @return 체크상태가 N가 된 행의 수
	 */
	public int chkN(ChkVO chkVO);

	/**
	 * @param chkVO
	 * @return 등록된 체크리스트 행의 수
	 */
	public int addChkList(ChkVO chkVO);

	/**
	 * @param chkVO
	 * @return 삭제된 체크리스트 행의 수
	 */
	public int delChkList(ChkVO chkVO);

	/**
	 * @param cmntVO
	 * @return 등록된 댓글의 수
	 */
	public int createCmnt(CmntVO cmntVO);

	/**
	 * @param cmntVO
	 * @return 삭제된 댓글의 수
	 */
	public int delCmntList(CmntVO cmntVO);

	/**
	 * @param cmntVO
	 * @return 수정된 댓글의 수
	 */
	public int updateCmnt(CmntVO cmntVO);

	/**
	 * @param taskVO
	 * @return 상태가 변경된 태스크의 수
	 */
	public int updateSsts(TaskVO taskVO);

	/**
	 * @param taskVO
	 * @return 등록된 태스크 설명의 수
	 */
	public int createExp(TaskVO taskVO);

	/**
	 * @param taskVO
	 * @return 라벨이 등록된 태스크의 수
	 */
	public int createLabel(TaskVO taskVO);

	/**
	 * 파일 업로드 후 파일그룹번호 업데이트
	 * @param taskVO
	 */
	public void taskUpdate(TaskVO taskVO);

	/**
	 * 파일 삭제
	 * @param filesVO
	 * @return
	 */
	public int deleteFile(FilesVO filesVO);

	/**
	 * @param empVO
	 * @return 메인페이지 프로젝트 목록
	 */
	public List<ProjVO> mainProjList(EmpVO empVO);

}
