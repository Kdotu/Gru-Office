package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoteVO {
	private String msgNo;//쪽지번호
	private String empNoSndpty;//발신자번호
	
	private String sender;//발신자명
	private String rcvr;//수신자명
	
	private String msgCn;//쪽지내용
	private Date msgDsptchDt;//발신일시
	private String msgCateTag;//쪽지태그(일반/긴급)
	private String msgClsfNo;//쪽지분류번호(기본/임시)
	
	private int rnum;//순번
	
	private List<MsgRcvrVO> noteList;//1:n = 발신자:수신자
	
	private String empNoRcvr;//수신자번호
	
	private String rcvrMsgNo;//수신자기본키번호
	
	//쪽지번호 받아오기(N개)_임시보관
	private String msgNoString;
	
	//쪽지번호 받아오기(N개)_삭제
	private List<String> msgNoArray;
}
