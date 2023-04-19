package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CmntVO {
	//댓글 번호
	private int cmntNo;

	private String empNo;

	//댓글 등록자(사원번호)
	private String cEmpNo;

	//댓글 등록자(사원명 + 직위)
	private String empTitle;
	//댓글등록자 부서명
	private String empDeptNm;

	//사원프로필 경로
	private String eFileStrgNm;

	//댓글 분류
	private String cmntClsf;

	//댓글 내용
	private String cmntCn;

	//댓글 등록일시
	private String cmntRegYmd;

	// 댓글등록자의 프로필 사진정보
	private String cmntProfile;


	// 설문조사 제목
	private String srvyTtl;
	// 설문조사 번호
	private String srvyNo;

}
