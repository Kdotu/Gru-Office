package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

// 설문조사
@Data
public class SrvyVO {
	// 설문조사 번호
	private String srvyNo;
	// 설문조사 등록자
	private String empNo;
	// 설문조사 파일 그룹번호
	private String fileGroupNo;
	// 설문조사 제목
	private String srvyTtl;
	// 설문조사 설명
	private String srvyExpln;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	// 설문조사 등록일자
	private Date srvyRegYmd;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	// 설문조사 시작일자
	private Date srvyBgngYmd;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	// 설문조사 종료일자
	private Date srvyEndYmd;
	// 설문조사 진행상태
	private String srvySsts;

	// 설문 작성자명
	private String empNm;
	// 설문 작성자 직급명
	private String jbpsNm;
	//설문 작성자 부서명
	private String deptNm;
	// 설문 작성자(사원명 + 직위)
	private String empTitle;


	// 설문등록자의 프로필 사진정보
	private String srvyProfile;

	// 질문항목
	List<SrvyQstnVO> srvyQstnVOList;
	// 답변항목
	List<SrvyRspnVO> srvyRspnVOList;
	// 질문 보기항목
	List<SrvyQstnArtVO> srvyQstnArtVOList;
	// 설문조사 대상자
	List<SrvyTrprVO> srvyTrprVOList;

	//파일
	private MultipartFile[] uploadFile;
	//첨부파일 그룹번호
	private FileGrVO fileGrVO;

	// 진행중인 설문조사 수
	private int progressCnt;
	// 보류된 설문조사 수
	private int holdCnt;
	// 마감된 설문조사 수
	private int endCnt;
	// 등록한 설문조사 수
	private int enrollCnt;

	// 설문조사 응답수
	private String srvyRspnsCnt;
	// 설문조사 댓글수
	private String srvyCmntCnt;
	// 설문조사 대상자수
	private String srvyTrprCnt;
	// 설문조사 응답여부
	private String rspnYn;







}
