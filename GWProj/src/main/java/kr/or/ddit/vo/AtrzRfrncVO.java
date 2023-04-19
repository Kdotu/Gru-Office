package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AtrzRfrncVO {
	//결재참조번호
	private int atrzRfrncNo;
	//참조자
	private String empNo;
	//결재선정보번호
	private String atrzLineInfoNo;
	//수신일시
	private Date atrzRfrncRcptnDt;
}
