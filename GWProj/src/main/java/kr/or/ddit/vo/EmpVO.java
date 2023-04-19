package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EmpVO implements Serializable{
	// 사원번호
	private String empNo;
	// 직위번호
	private String jbpsNo;
	// 부서번호
	private String deptNo;
	// 소속회사
	private String empOgdpCo;
	// 비밀번호
	private String empPswd;
	// 사원명
	private String empNm;
	// 주민등록번호(사업자등록번호)
	private String empRrno;
	// 생년월일
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date empBrdt;
	// 성별
	private String empGender;
	// 휴대전화
	private String empMblTelno;
	// 사내전화
	private String empCoTelno;
	// 이메일
	private String empEmlAddr;
	// 우편번호
	private String empZip;
	// 일반주소
	private String empAddr;
	// 상세주소
	private String empDaddr;
	// 입사일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date empJncmpYmd;

	// 입사일자(String 형태 추가)
	private String empJncmpYmds;

	// 재직상태
	private String empHdofYn;
	//퇴사일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date empRsgntnYmd;
	// 생성연차
	private int empCrtHoli;

	// 사원  : 권한 = 1 : N
	private List<AuthrtVO> empAuthVOList;
	// 부서명
	private String deptNm;
	// 직위명
	private String jbpsNm;

	//상위부서 번호
	private String upDeptNo;
	//상위부서 이름
	private String UpDeptNm;
	//부서레벨
	private int lvl;

	//근무상태
	private String workMngSsts;
	//근무상세
	private String workMngDtlCn;
	// 출근일시
	private String workMngBgngDt;
	// 퇴근일시
	private String workMngEndDt;

	// 소속회사명
	private String empOgdpCoNm;


	//첨부파일그룹번호
	private String fileGroupNo;

	//파일
	private MultipartFile[] uploadFile;
	//첨부파일 그룹번호
	private FileGrVO fileGrVO;
	
	//직원 프로필 사진 경로 
	private String empProfile; 



}
