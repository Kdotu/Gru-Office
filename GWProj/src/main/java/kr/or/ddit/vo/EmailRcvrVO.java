package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EmailRcvrVO {

	private String emlRcvrAddr;//이메일주소
	private String rcvr;//수신자명
	private String emlNo;//메일번호
//	private String emlRfrncYn;//참조인여부
	private String emlRcptnYn;//수신확인여부
	private Date emlRcptnDt;//수신확인일시
//	private String reciever;//수신자
}
