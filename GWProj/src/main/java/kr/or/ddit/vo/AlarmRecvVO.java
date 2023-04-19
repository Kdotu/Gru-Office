package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AlarmRecvVO {
	//알림번호
	private int alarmNo;

	//알림수신자
	private String empNo;
}
