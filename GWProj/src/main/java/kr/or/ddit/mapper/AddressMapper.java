package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AddrVO;
import kr.or.ddit.vo.BookmarkVO;

public interface AddressMapper {

	/** 주소록 목록 불러오는 함수
	 * @param map
	 * @return AddrVO를 담은 List
	 */
	public List<AddrVO> getAllAddrList(Map<String, String> map);
	
	/**주소록 상세화면
	 * @param addrVO
	 * @return addrVO
	 */
	public AddrVO detail(AddrVO addrVO);
	
	/** 주소록 추가
	 * @param addrVO
	 * @return int값
	 */
	public int createPost(AddrVO addrVO);
	
	/** 주소록 삭제
	 * @param addrVO
	 * @return int값
	 */
	public int deletePost(AddrVO addrVO);
	
	/**주소록 삭제(다중)
	 * @param addrVO
	 * @return int값
	 */
	public int deleteMulti(AddrVO addrVO);
	
	/** 전체 행의 수 구하기
	 * @param keyword
	 * @return int값
	 */
	public int getTotal(Map<String, String> map);
	
	
	
	/** 즐겨찾기 주소록에 추가
	 * @param addrVO
	 * @return List<AddrVO>
	 */
	public int sendBookMark(BookmarkVO bookmarkVO);
	
	/** 즐겨찾기 목록 불러오는 함수
	 * @param bookmarkVO
	 * @return List<AddrVO>
	 */
	public List<AddrVO> bookMarkList(AddrVO addrVO);
	
	/** 즐겨찾기 주소록 삭제(다중)
	 * @param bookmarkVO
	 * @return int값
	 */
	public int bookmarkDel(BookmarkVO bookmarkVO);
	
	/** 주소록 목록(메일쓰기에서 사용)
	 * @param map
	 * @return List<AddrVO>
	 */
	public List<AddrVO> addrList(Map<String, String> map);
	
	/** 이메일주소 가져오는 함수(메일쓰기에서 사용)
	 * @param addrVO
	 * @return List<AddrVO>
	 */
	public List<AddrVO> checkAddr(AddrVO addrVO);
	
	/**내메일주소 받아오기(메일쓰기에서 사용)
	 * @param addrVO
	 * @return
	 */
	public String getMyEmail(AddrVO addrVO);
	
	/** 주소록 수정
	 * @param addrVO
	 * @return int
	 */
	public int updatePost(AddrVO addrVO);

}
