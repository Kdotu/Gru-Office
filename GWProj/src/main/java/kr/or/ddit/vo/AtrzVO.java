package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AtrzVO {
	//결재순서
	private int atrzSeq;
	//결재선정보번호
	private String atrzLineInfoNo;
	//사원번호 (기안자)
	private String empNo;
	//결재여부
	private String atrzYn;
	//결재일시
	private Date atrzDt;
	//반려사유
	private String atrzRjctRsn;
	
	
	//사원번호 (결재자)
	private String empNoAtrz;
}
