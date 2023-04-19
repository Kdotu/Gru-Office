package kr.or.ddit.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AddressMapper;
import kr.or.ddit.service.AddressService;
import kr.or.ddit.vo.AddrVO;
import kr.or.ddit.vo.BookmarkVO;

@Service
public class AddressServiceImpl implements AddressService {

	@Autowired
	AddressMapper addressMapper;
	
	/** 주소록 목록 불러오는 함수
	 * @param map
	 * @return List<AddrVO>
	 */
	@Override
	public List<AddrVO> getAllAddrList(Map<String, String> map) {
		return this.addressMapper.getAllAddrList(map);
	}
	
	/**주소록 상세화면
	 * @param addrVO
	 * @return addrVO
	 */
	@Override
	public AddrVO detail(AddrVO addrVO) {
		return this.addressMapper.detail(addrVO);		
	}
	
	/** 주소록 추가
	 * @param addrVO
	 * @return int값
	 */
	@Override
	public int createPost(AddrVO addrVO) {
		return this.addressMapper.createPost(addrVO);		
	}
	
	/** 주소록 삭제
	 * @param addrVO
	 * @return int값
	 */
	@Override
	public int deletePost(AddrVO addrVO) {
		return this.addressMapper.deletePost(addrVO);		
	}
	
	/**주소록 삭제(다중)
	 * @param addrVO
	 * @return int값
	 */
	@Override
	public int deleteMulti(AddrVO addrVO) {
		return addressMapper.deleteMulti(addrVO);
	}

	/** 전체 행의 수 구하기
	 * @param keyword
	 * @return int값
	 */
	@Override
	public int getTotal(Map<String, String> map) {		
		return addressMapper.getTotal(map);
	}
	/** 
	 * 전체 행의 수 구하기(메일 주소록에서 사용)
	 * @param keyword
	 * @return int값
	 */
	
	

	/** 즐겨찾기 주소록에 추가
	 * @param addrVO
	 * @return List<AddrVO>
	 */
	@Override
	public int sendBookMark(BookmarkVO bookmarkVO) {
		return addressMapper.sendBookMark(bookmarkVO);		
	}
	
	/** 즐겨찾기 목록 불러오는 함수
	 * @param bookmarkVO
	 * @return List<AddrVO>
	 */
	@Override
	public List<AddrVO> bookMarkList(AddrVO addrVO){
		return addressMapper.bookMarkList(addrVO);
	}
	
	/** 즐겨찾기 주소록 삭제(다중)
	 * @param bookmarkVO
	 * @return int값
	 */
	@Override
	public int bookmarkDel(BookmarkVO bookmarkVO) {
		return addressMapper.bookmarkDel(bookmarkVO);
	}
	
	/** 주소록 목록(메일쓰기에서 사용)
	 * @param map
	 * @return List<AddrVO>
	 */
	@Override
	public List<AddrVO> addrList(Map<String, String> map){
		return addressMapper.addrList(map);
	}
	
	/** 이메일주소 가져오는 함수(메일쓰기에서 사용)
	 * @param addrVO
	 * @return List<AddrVO>
	 */
	@Override
	public List<AddrVO> checkAddr(AddrVO addrVO){
		return addressMapper.checkAddr(addrVO);
	}
	
	/**내메일주소 받아오기(메일쓰기에서 사용)
	 * @param addrVO
	 * @return
	 */
	public String getMyEmail(AddrVO addrVO) {
		return addressMapper.getMyEmail(addrVO);
	}
	
	/** 주소록 수정
	 * @param addrVO
	 * @return int
	 */
	public int updatePost(AddrVO addrVO) {
		return addressMapper.updatePost(addrVO);
	}


}
