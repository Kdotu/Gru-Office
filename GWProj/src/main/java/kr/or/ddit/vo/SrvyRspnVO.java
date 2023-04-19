package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

// 설문조사 - 응답
@Data
public class SrvyRspnVO {
	// 답변번호
	private String srvyRspnsNo;
	// 질문번호
	private String srvyQstnNo;
	// 설문조사 번호
	private String srvyNo;
	// 사원번호(답변자)
	private String empNo;
	// 답변등록일자
	private Date srvyRspnsRegYmd;
	// 답변내용
	private String srvyRspnsCn;


	// 질문명
	private String srvyQstnNm;
	// 답변한 보기내용
	private String srvyQstnArtNm;
	// 질문에 대한 답변 갯수
	private int rspnsCnt;
	// 질문에 대한 전체 답변 갯수
	private int totalRspnCnt;
	// 답변된 질문 보기번호
	private String srvyQstnArtclOrder;
	// 답변된 질문보기 내용
	private String srvyQstnArtclCn;

}
