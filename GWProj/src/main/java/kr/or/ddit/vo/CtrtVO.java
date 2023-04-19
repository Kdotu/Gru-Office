package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

//하도급계약요청서
@Data
public class CtrtVO {
	//문서번호
	private String edocNo;
	//계약명
	private String ctrtNm;
	//계약시작날짜
	private Date ctrtBgngYmd;
	//계약종료날짜
	private Date ctrtEndYmd;
	//계약금액
	private int ctrtAmt;
	//납부기한일자
	private Date ctrtTermYmd;
	//거래처
	private String ctrtCnpt;
	//거래처법인번호
	private int ctrtCorpNo;
	//계약내용
	private String ctrtCn;
	//비고
	private String ctrtExt;
	//계정과목코드
	private String subCd;
}
