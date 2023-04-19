package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.HashTagListVO;
import kr.or.ddit.vo.HashTagVO;
import kr.or.ddit.vo.SrvyQstnArtVO;
import kr.or.ddit.vo.SrvyQstnVO;
import kr.or.ddit.vo.SrvyRspnVO;
import kr.or.ddit.vo.SrvyTrprVO;
import kr.or.ddit.vo.SrvyVO;

public interface SrvyService {

	/**
	 * 설문조사에 관한 정보를 입력받아 설문조사를 등록하는 메서드
	 * @param srvyVO
	 * @return
	 */
	public int createSurvey(SrvyVO srvyVO);

	/**
	 * 설문조사 대상자 정보를 추가하는 메서드
	 * @param srvyTrprVO
	 * @return
	 */
	public int createSurveyTrpr(SrvyTrprVO srvyTrprVO);


	/**
	 * 설문조사 질문 정보를 추가하는 메서드
	 * @param srvyQstnVO
	 * @return
	 */
	public int createSurveyQstn(SrvyQstnVO srvyQstnVO);

	/**
	 * 설문조사 질문에 대한 보기 정보를 추가하는 메서드
	 * @param srvyQstnArtVO
	 * @return
	 */
	public int createSurveyQstnArt(SrvyQstnArtVO srvyQstnArtVO);

	/**
	 * 설문조사 답변 정보를 저장하는 메서드
	 * @param srvyRspnVO
	 * @return
	 */
	public int createSurveyRspn(SrvyRspnVO srvyRspnVO);

	/**
	 * 등록된 해시태그 목록을 반환하는 메서드
	 * @param hashMap
	 * @return
	 */
	public List<HashTagListVO> getHashTagList(Map<String,String> hashMap);

	/**
	 * 검색 조건을 map에 담아 조건에 맞는 설문조사 목록을 가져오는 메서드
	 * @param srvyMap
	 * @return
	 */
	public List<SrvyVO> getSrvyList(Map<String,Object> srvyMap);


	/**
	 * 설문조사 번호를 입력받아 설문조사의 상세 정보를 가져오는 메서드
	 *
	 * @param srvyNo
	 * @return 설문조사 정보,질문,질문보기
	 */
	public List<SrvyVO> getSrvyDetail(String srvyNo);


	/**
	 * 해당 사원이 설문조사에서 답변한 내용을 가져오는 메서드
	 * @param rspnMap (empNo : 답변한 사원의 사원번호 / srvyNo : 답변한 설문조사번호)
	 * @return
	 */
	public List<SrvyRspnVO> getSrvyRspn(Map<String,String> rspnMap);


	/**
	 * 해시태그 사용 정보를 추가하는 메서드
	 * @param hashTagMap
	 * @return
	 */
	public int createHashTagUse(Map<String,Object> hashTagMap);

	/**
	 * 해시태그명이 중복되었는지 검사하는 메서드
	 * @param hashTagListVO
	 * @return
	 */
	public List<HashTagListVO> hashTagNmChk(HashTagListVO hashTagListVO);

	/**
	 * 신규 해시태그를 추가하는 메서드
	 * @param hashTagListVO
	 * @return
	 */
	public int createHashTag(HashTagListVO hashTagListVO);

	/**
	 * 등록되어있는 해시태그를 삭제하는 메서드
	 * @param hashTagListVO
	 * @return
	 */
	public int deleteHashTag(HashTagListVO hashTagListVO);


	/**
	 * 등록되어있는 해시태그의 사용여부 상태를 수정하는 메서드
	 * @param hashTagListVO
	 * @return
	 */
	public int modifyUseYn(HashTagListVO hashTagListVO);



	/**
	 * 해당 설문조사에서 사용한 해시태그 정보를 가져오는 메서드
	 *
	 * @param srvyVO
	 * @return
	 */
	public List<HashTagVO> getUsedHashTag(SrvyVO srvyVO);


	/**
	 * 해당 설문조사의 댓글 목록을 가져오는 메서드
	 * @param srvyVO
	 * @return
	 */
	public List<CmntVO> getSrvyComment(SrvyVO srvyVO);


	/**
	 * 등록한 설문조사 중 최신 댓글 5개를 가져오는 메서드
	 * @param srvyVO
	 * @return
	 */
	public List<CmntVO> getSrvyRecentComment(SrvyVO srvyVO);

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
	 * 설문조사 등록 정보를 수정하는 메서드
	 * @param srvoVO
	 * @return
	 */
	public int modifySrvyInfo(SrvyVO srvyVO);


	/**
	 * 진행/보류/마감/등록한 설문조사의 수를 가져오는 메서드
	 * @param srvyVO
	 * @return
	 */
	public SrvyVO getSrvyCnt(SrvyVO srvyVO);


	/**
	 * 대상인 설문조사 리스트를 가져오는 메서드
	 * @param srvyVO
	 * @return
	 */
	public List<SrvyVO> getSrvyTrprList(SrvyVO srvyVO);
	/**
	 * 등록한 설문조사 리스트를 가져오는 메서드
	 * @param srvyVO
	 * @return
	 */
	public List<SrvyVO> getSrvyEnrollList(SrvyVO srvyVO);

	/**
	 * 설문조사 질문에 대한 답변의 수를 가져오는 메서드
	 * @param srvyVO
	 * @return
	 */
	public List<SrvyRspnVO> getRspnCntChart(SrvyVO srvyVO);

	/**
	 * 해당 설문의 설문대상자의 정보를 가져오는 메서드
	 * @param srvyNo
	 * @return
	 */
	public List<SrvyTrprVO> getTrprVOList(String srvyNo);

	/**
	 * 전체 설문조사의 수를 가져오는 메서드(페이징용)
	 * @param srvyMap
	 * @return
	 */
	public int getSrvyTotal(Map<String,Object> srvyMap);

	/**
	 * 설문조사를 삭제하는 메서드
	 * @return
	 */
	public int deleteSrvy(SrvyVO srvyVO);

	/**
	 * 설문조사의 대상자수와 답변수를 가져오는 메서드
	 * (비교 후 두 수가 일치할 때 설문조사의 상태 업데이트)
	 * @param srvyNo
	 * @return
	 */
	public SrvyVO getTrprRspnsCnt(String srvyNo);


	/**
	 * 관리자페이지에서 모든 설문조사의 목록을 가져오는 메서드
	 * @param srvyMap
	 * @return
	 */
	public List<SrvyVO> getAdminSrvyList(Map<String, Object> srvyMap);

	/**
	 * 관리자페이지에서 모든 설문조사의 목록 수를 가져오는 메서드
	 * @param srvyMap
	 * @return
	 */
	public int getAdminSrvyTotalList(Map<String, Object> srvyMap);

}

