package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.GoodVO;
import kr.or.ddit.vo.WholBVO;

/**
 * @author PC-01
 *
 */
public interface WholBService {

	/** 부서게시글 등록
	 * @param wholBVO
	 * @return
	 */
	public int depBWritePost(WholBVO wholBVO);

	/** 전사게시글 등록
	 * @param wholBVO
	 * @return
	 */
	public int wholBWritePost(WholBVO wholBVO);

	/** 전사게시글 목록
	 * @param wholBVO
	 * @return List<WholBVO>
	 */
	public List<WholBVO> wholBList(WholBVO wholBVO);


	/** 전사게시글 상세보기
	 * @param wholBVO
	 * @return WholBVO
	 */
	public WholBVO wholBDetail(String wholBbsNo);

	/** 좋아요 기능
	 * @param goodVO
	 * @return int
	 */
	public int wholBLikeUp(GoodVO goodVO);

	/** 전사게시글 삭제
	 * @param wholBVO
	 * @return int
	 */
	public int delWholB(WholBVO wholBVO);


	/** 내가 쓴 글 받아오기
	 * @param wholBVO
	 * @return List<WholBVO>
	 */
	public List<WholBVO> selMyBList(WholBVO wholBVO);

	/** 댓글 등록
	 * @param wholBVO
	 * @return int
	 */
	public int createCmnt(CmntVO CmntVO);

	/** 댓글 수정
	 * @param cmntVO
	 * @return int
	 */
	public int updateCmnt(CmntVO cmntVO);

	/** 댓글 삭제
	 * @param cmntCn
	 * @return int
	 */
	public int deleteCmnt(CmntVO cmntVO);

	/** 댓글 수 조회
	 * @param wholBVO
	 * @return int
	 */
	public int cmntCnt(WholBVO wholBVO);

	/** 부서게시글 목록 조회
	 * @param wholBVO
	 * @return List<WholBVO>
	 */
	public List<WholBVO> depBList(WholBVO wholBVO);

	/** 공지게시글 목록 조회
	 * @param wholBVO
	 * @return List<WholBVO>
	 */
	public List<WholBVO> noticeBList();

	/**공지 상세보기 조회
	 * @param wholBVO
	 * @return WholBVO
	 */
	public WholBVO noticeBDetail(String wholBbsNo);

	/** 공지게시글 등록
	 * @param wholBVO
	 * @return int
	 */
	public int noticeBWritePost(WholBVO wholBVO);

	/**
	 * @return 메인 공지게시판
	 */
	public List<WholBVO> mainNotice();

	/**
	 * @return 메인 전사게시판
	 */
	public List<WholBVO> mainWhole();

	/**
	 * @param username
	 * @return 메인 부서게시판
	 */
	public List<WholBVO> mainDept(String username);


	/**
	 * @param username
	 * @return 로그인한 사원의 부서이름
	 */
	public String getDeptNm(String username);

	/**
	 * 게시판을 수정하는 메서드
	 * @return
	 */
	public int wholBModify(WholBVO wholBVO);

	/** 기본키로 게시글 한 행 가져오기
	 * @param wholBVO
	 * @return WholBVO
	 */
	public WholBVO selectLow(WholBVO wholBVO);

	/** 전사게시글 수정
	 * @param wholBVO
	 * @return int
	 */
	public int wholBModi(WholBVO wholBVO);

	/** 좋아요 클릭 조회
	 * @param wholBVO
	 * @return int
	 */
	public int selectCnt(GoodVO goodVO);

}





