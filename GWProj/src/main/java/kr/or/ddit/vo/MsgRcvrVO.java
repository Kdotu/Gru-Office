package kr.or.ddit.vo;

import lombok.Data;

@Data
public class MsgRcvrVO {
	private String rcvrMsgNo;//수신쪽지번호
	private String msgNo;//쪽지번호
	private String empNoRcvr;//수신자
}
