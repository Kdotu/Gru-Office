package kr.or.ddit.service.Impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.EmpMapper;
import kr.or.ddit.mapper.SrvyMapper;
import kr.or.ddit.service.SrvyService;
import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.HashTagListVO;
import kr.or.ddit.vo.HashTagVO;
import kr.or.ddit.vo.SrvyQstnArtVO;
import kr.or.ddit.vo.SrvyQstnVO;
import kr.or.ddit.vo.SrvyRspnVO;
import kr.or.ddit.vo.SrvyTrprVO;
import kr.or.ddit.vo.SrvyVO;

@Service
public class SrvyServiceImpl implements SrvyService{

	@Inject
	SrvyMapper srvyMapper;
	@Inject
	EmpMapper empMapper;

	@Transactional
	@Override
	public int createSurvey(SrvyVO srvyVO) {
		// INSERT 순서 (설문조사 insert -> 질문 insert, 보기 insert / 설문대상 insert)
		int res = 0;
		int srvyRes = this.srvyMapper.createSurvey(srvyVO);

		if(srvyVO.getSrvyNo() != null) {
			int srvyQstnRes = 0;
			int srvyQstnArtRes = 0;

			// 질문추가
			for(SrvyQstnVO srvyQstnVO : srvyVO.getSrvyQstnVOList()) {
				srvyQstnVO.setSrvyNo(srvyVO.getSrvyNo());
				srvyQstnRes += this.srvyMapper.createSurveyQstn(srvyQstnVO);
				if(srvyQstnVO.getSrvyQstnType().equals("QSTN0001")) {
					// 질문 보기 추가 (선택형일 경우)
					for(SrvyQstnArtVO srvyQstnArtVO : srvyQstnVO.getSrvyQstnArtVOList()) {
						srvyQstnArtVO.setSrvyNo(srvyVO.getSrvyNo());
						srvyQstnArtVO.setSrvyQstnNo(srvyQstnVO.getSrvyQstnNo());
						srvyQstnArtRes += this.srvyMapper.createSurveyQstnArt(srvyQstnArtVO);
						// 하나라도 insert 실패시 탈출
					}
					if(srvyQstnArtRes < srvyQstnVO.getSrvyQstnArtVOList().size()) {
						return 0;
					}
				}
			}
			// 하나라도 insert 실패시 탈출
			if(srvyQstnRes < srvyVO.getSrvyQstnVOList().size()) {
				return 0;
			}

			if(srvyVO.getSrvyTrprVOList() != null) {
				// 설문대상자 추가
				for(SrvyTrprVO srvyTrprVO : srvyVO.getSrvyTrprVOList()) {
					System.out.println("srvyTrprVO===========> : " + srvyTrprVO);
					srvyTrprVO.setSrvyNo(srvyVO.getSrvyNo());
					if(srvyTrprVO.getDeptNo() == null ) { // 일반 사원 대상일 경우
						this.srvyMapper.createSurveyTrpr(srvyTrprVO);
					}else{
						if(srvyTrprVO.getDeptNo().equals("all")) {
						// 전사원추가

						}else {
						// 부서 대상일 경우

						// 부서번호를 이용해서 해당 부서원 정보 다 가져오기
						List<SrvyTrprVO> srvyTrprDeptList = this.empMapper.getDeptEmp(srvyTrprVO.getDeptNo());
						// 부서원별로 insert 반복문
						for(SrvyTrprVO srvyTrprDeptVO : srvyTrprDeptList) {
							if( srvyTrprDeptVO.getEmpNo().equals(srvyVO.getEmpNo()) ) {
								continue;
							}
							System.out.println("srvyTrprDeptVO : " + srvyTrprDeptVO);
							srvyTrprDeptVO.setSrvyNo(srvyVO.getSrvyNo());
							this.srvyMapper.createSurveyTrpr(srvyTrprDeptVO);
						}
					}
				}
					res = 1;
				}
			}
		}
		// 성공 결과 반환
		return res;
	}

	@Override
	public int createSurveyTrpr(SrvyTrprVO srvyTrprVO) {
		return this.srvyMapper.createSurveyTrpr(srvyTrprVO);
	}

	@Override
	public int createSurveyQstn(SrvyQstnVO srvyQstnVO) {
		return this.srvyMapper.createSurveyQstn(srvyQstnVO);
	}

	@Override
	public int createSurveyQstnArt(SrvyQstnArtVO srvyQstnArtVO) {
		return this.srvyMapper.createSurveyQstnArt(srvyQstnArtVO);
	}

	@Override
	public int createSurveyRspn(SrvyRspnVO srvyRspnVO) {
		return this.srvyMapper.createSurveyRspn(srvyRspnVO);
	}

	@Override
	public List<HashTagListVO> getHashTagList(Map<String,String> hashMap) {
		return this.srvyMapper.getHashTagList(hashMap);
	}

	@Override
	public List<SrvyVO> getSrvyList(Map<String, Object> srvyMap) {
		return this.srvyMapper.getSrvyList(srvyMap);
	}

	@Override
	public List<SrvyVO> getSrvyDetail(String srvyNo) {
		return this.srvyMapper.getSrvyDetail(srvyNo);
	}

	@Override
	public int createHashTagUse(Map<String, Object> hashTagMap) {
		int res = 0;
		String srvyNo = (String) hashTagMap.get("srvyNo");
		// 해시태그 그룹 번호 생성
		int grCreateRes = this.srvyMapper.createHashTagGr(srvyNo);
		// 그룹번호가 성공적으로 생성되면 해시태그 사용처 추가
		if(grCreateRes > 0) {
			res = this.srvyMapper.createHashTagUse(hashTagMap);
		}
		return res;
	}

	@Override
	public List<SrvyRspnVO> getSrvyRspn(Map<String, String> rspnMap) {
		return this.srvyMapper.getSrvyRspn(rspnMap);
	}

	@Override
	public List<HashTagVO> getUsedHashTag(SrvyVO srvyVO) {
		return this.srvyMapper.getUsedHashTag(srvyVO);
	}

	@Override
	public List<CmntVO> getSrvyComment(SrvyVO srvyVO) {
		return this.srvyMapper.getSrvyComment(srvyVO);
	}

	@Override
	public int createCmnt(CmntVO cmntVO) {
		return this.srvyMapper.createCmnt(cmntVO);
	}

	@Override
	public int delCmntList(CmntVO cmntVO) {
		return this.srvyMapper.delCmntList(cmntVO);
	}

	@Override
	public int updateCmnt(CmntVO cmntVO) {
		return this.srvyMapper.updateCmnt(cmntVO);
	}

	@Override
	public int modifySrvyInfo(SrvyVO srvoVO) {
		return this.srvyMapper.modifySrvyInfo(srvoVO);
	}

	@Override
	public List<HashTagListVO> hashTagNmChk(HashTagListVO hashTagListVO) {
		return this.srvyMapper.hashTagNmChk(hashTagListVO);
	}

	@Override
	public int createHashTag(HashTagListVO hashTagListVO) {
		return this.srvyMapper.createHashTag(hashTagListVO);
	}

	@Override
	public int deleteHashTag(HashTagListVO hashTagListVO) {
		return this.srvyMapper.deleteHashTag(hashTagListVO);
	}

	@Override
	public int modifyUseYn(HashTagListVO hashTagListVO) {
		return this.srvyMapper.modifyUseYn(hashTagListVO);
	}

	@Override
	public List<CmntVO> getSrvyRecentComment(SrvyVO srvyVO) {
		return this.srvyMapper.getSrvyRecentComment(srvyVO);
	}

	@Override
	public SrvyVO getSrvyCnt(SrvyVO srvyVO) {
		return this.srvyMapper.getSrvyCnt(srvyVO);
	}

	@Override
	public List<SrvyVO> getSrvyTrprList(SrvyVO srvyVO) {
		return this.srvyMapper.getSrvyTrprList(srvyVO);
	}

	@Override
	public List<SrvyVO> getSrvyEnrollList(SrvyVO srvyVO) {
		return this.srvyMapper.getSrvyEnrollList(srvyVO);
	}

	@Override
	public List<SrvyRspnVO> getRspnCntChart(SrvyVO srvyVO) {
		return this.srvyMapper.getRspnCntChart(srvyVO);
	}

	@Override
	public List<SrvyTrprVO> getTrprVOList(String srvyNo) {
		return this.srvyMapper.getTrprVOList(srvyNo);
	}

	@Override
	public int getSrvyTotal(Map<String, Object> srvyMap) {
		return this.srvyMapper.getSrvyTotal(srvyMap);
	}

	@Override
	public int deleteSrvy(SrvyVO srvyVO) {
		return this.srvyMapper.deleteSrvy(srvyVO);
	}

	@Override
	public SrvyVO getTrprRspnsCnt(String srvyNo) {
		return this.srvyMapper.getTrprRspnsCnt(srvyNo);
	}

	@Override
	public List<SrvyVO> getAdminSrvyList(Map<String, Object> srvyMap) {
		return this.srvyMapper.getAdminSrvyList(srvyMap);
	}

	@Override
	public int getAdminSrvyTotalList(Map<String, Object> srvyMap) {
		return this.srvyMapper.getAdminSrvyTotalList(srvyMap);
	}


}
