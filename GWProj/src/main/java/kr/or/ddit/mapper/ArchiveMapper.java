package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ArchiveVO;
import kr.or.ddit.vo.BookmarkVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ArchiveMapper {

	/** 자료실에 자료를 insert하는 메서드
	 * @param archiveVOList
	 * @return 성공시 1  실패시 0
	 */
	public int create(List<ArchiveVO> archiveVOList);


	/** 로그인 한 사원의 개인자료실의 자료의 총 개수를 count하는 메서드
	 * @param pagingVO
	 * @return 개인자료실 자료의 총 개수
	 */
	public int getPersonalTotal(PaginationInfoVO<ArchiveVO> pagingVO);


	/** 로그인 한 사원의 개인자료실의 자료를 가져오는 메서드
	 * @param pagingVO
	 * @return 개인자료실 자료 리스트
	 */
	public List<Map<String, Object>> getPersonal(PaginationInfoVO<ArchiveVO> pagingVO);


	/** 자료실의 자료를 삭제하는 메서드
	 * @param map
	 * @return 성공시 1 실패시 0
	 */
	public int deleteFile(Map<String, Object> map);


	/** 공용자료실의 자료의 총 개수를 count하는 메서드
	 * @param pagingVO
	 * @return 공용자료실 자료의 총 개수
	 */
	public int getPublicTotal(PaginationInfoVO<ArchiveVO> pagingVO);


	/** 공용자료실의 자료를 가져오는 메서드
	 * @param pagingVO
	 * @return  공용자료실 자료 리스트
	 */
	public List<Map<String, Object>> getPublic(PaginationInfoVO<ArchiveVO> pagingVO);


	/** 내가 속한 부서의 자료의 총 개수를 count하는 메서드(부서자료실)
	 * @param pagingVO
	 * @return 내가 속한 부서의 자료의 총 개수
	 */
	public int getDeptTotal(PaginationInfoVO<ArchiveVO> pagingVO);


	/** 내가 속한 부서의 자료를 가져오는 메서드(부서자료실)
	 * @param pagingVO
	 * @return 내가 속한 부서의 자료 리스트
	 */
	public List<Map<String, Object>> getDept(PaginationInfoVO<ArchiveVO> pagingVO);


	/** 즐겨찾기(북마크)를 추가하는 메서드
	 * @param bookmarkVO
	 * @return 성공시 1 실패시 0
	 */
	public int createBookmark(BookmarkVO bookmarkVO);


	/**  즐겨찾는 자료실의 자료의 총 개수를 count하는 메서드
	 * @param pagingVO
	 * @return 즐겨찾는 자료의 총 개수
	 */
	public int getBookmarkTotal(PaginationInfoVO<ArchiveVO> pagingVO);

	/**  즐겨찾는 자료실의 자료를 가져오는 메서드
	 * @param pagingVO
	 * @return 즐겨찾는 자료 리스트
	 */
	public List<Map<String, Object>> getBookmark(PaginationInfoVO<ArchiveVO> pagingVO);

	/** 즐겨찾기(북마크)를 삭제하는 메서드
	 * @param bookmarkVO
	 * @return 성공시 1 실패시 0
	 */
	public int deleteBookmark(BookmarkVO bookmarkVO);

	/** 개인자료실의 모든 자료의 파일크기의 합을 가져오는 메서드
	 * @param empNo
	 * @return 개인자료실의 모든 자료의 파일크기의 합
	 */
	public int getPersonalUsage(String empNo);

	/** 공용자료실의 모든 자료의 파일크기의 합을 가져오는 메서드
	 * @return 공용자료실의 모든 자료의 파일크기의 합
	 */
	public int getpublicUsage();

	/** 부서자료실의 모든 자료의 파일크기의 합을 가져오는 메서드
	 * @param empNo
	 * @return 부서자료실의 모든 자료의 파일크기의 합
	 */
	public int getDeptUsage(String empNo);

	/** 개인자료실 이미지의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @param empNo
	 * @return 개인자료실 이미지의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> personalImage(Map<String,Object> param);

	/** 부서자료실 이미지의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @param empNo
	 * @return 부서자료실 이미지의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> deptImage(String empNo);

	/** 공용자료실 이미지의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @return 공용자료실 이미지의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> publicImage();

	/**  개인자료실의 문서의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @param empNo
	 * @return 개인자료실의 문서의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> personalDoc(String empNo);

	/** 부서자료실의 문서의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @param empNo
	 * @return 부서자료실의 문서의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> deptDoc(String empNo);

	/** 공용자료실의 문서의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @return 공용자료실의 문서의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> publicDoc();

	/** 개인자료실의 미디어자료의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @param empNo
	 * @return 개인자료실의 미디어자료의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> personalMedia(String empNo);

	/** 부서자료실의 미디어자료의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @param empNo
	 * @return 부서자료실의 미디어자료의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> deptMedia(String empNo);

	/** 공용자료실의 미디어자료의 총 개수와 파일크기의 합을 가져오는 메서드
	 * @return 공용자료실의 미디어자료의 총 개수와 파일크기의 합
	 */
	public Map<String, Object> publictMedia();

}
