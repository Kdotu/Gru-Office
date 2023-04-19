package kr.or.ddit.vo;


import lombok.Data;

@Data
public class PrtpntVO {
	//참여자번호
	private String prtpntNo;

	//사원번호
	private String empNo;

	//사원번호
	private String pempno;

	//사원명
	private String empNm;

	//사원직위
	private String empJbps;

	//사원프로필 경로
	private String fileStrgNm;

	//일정번호
	private String calNo;

	//태스크번호
	private String taskNo;

	//프로젝트번호
	private String projNo;

	//참여자분류(=공통코드)
	private String prtpntClsf;

	//참여자분류(=공통코드명)
	private String cdNm;

	//체크박스된 사원 번호들
	private int[] empNoArray;
}
