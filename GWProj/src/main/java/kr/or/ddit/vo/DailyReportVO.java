package kr.or.ddit.vo;


import java.util.Date;

import lombok.Data;

@Data
public class DailyReportVO {
	// 일일보고 번호
	private String rptpNo;
	// 사원번호
	private String empNo;
	//작성일
	private Date rptpWrtYmd;
	// 금일업무목표
	private String rptpTaskGoal;
	// 현재진행업무
	private String rptpPrgrsTask;
	// 익일예정업무
	private String rptpPrnmntTask;
	// 보고완료여부
	private String rptpCmptnYn;
	// 보고완료일시
	private Date rptpCmptnDt;
	// 보고확인 담당자
	private String rptpCmptnPic;
	// 보고확인 담당자명
	private String rptpCmptnPicNm;
	// 보고확인 담당자 부서명
	private String rptpCmptnPicDeptNm;
	// 보고확인 담당자 직책명
	private String rptpCmptnPicJbpsNm;
	
	
	// 기타보고사항
	private String rptpEtc;

	
	// 보고회차 정보
	private Date dates;
	// 작성자명
	private String empNm;
	// 작성자 부서명
	private String deptNm;
	// 작성자 부서코드
	private String deptNo;
	// 작성자 직책명
	private String jbpsNm;
	// 작성자 직책코드
	private String jbpsNo;
	
	// 작성자 상위부서코드
	private String upDeptNo;
	// 작성자 상위부서명
	private String upDeptNm;
	
	
	// 일별 보고수
	private int dailyCnt;
	// 일별 미확인 보고수
	private int dailyNonchkCnt;
	// 주별 보고수
	private int weeklyCnt;
	// 주별 미확인 보고수
	private int weeklyNonchkCnt;
	// 월별 보고수
	private int monthlyCnt;
	// 월별 미확인 보고수
	private int monthlyNonchkCnt;
	// 부서원 수
	private int deptCnt;
	
}
