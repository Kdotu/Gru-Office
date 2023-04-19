package kr.or.ddit.vo;

import lombok.Data;

@Data
public class SrvyTrprVO {
	// 설문조사 번호
	private String srvyNo;
	// 설문조사 대상자
	private String empNo;

	// 설문조사 대상부서
	private String deptNo;
	// 설문조사 대상부서명
	private String deptNm;
	// 설문대상자(사원명 + 직위)
	private String trprEmpTitle;
	// 설문대상자의 프로필 사진정보
	private String srvyProfile;





}
