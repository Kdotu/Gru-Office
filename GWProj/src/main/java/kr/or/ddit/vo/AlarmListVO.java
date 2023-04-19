package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class AlarmListVO {
	//알림번호
	private int alarmNo;

	//알림발신자
	private String empNo;

	//알림발신자 이름+직위
	private String empTitle;

	//알림발신자 프로필
	private String fileStrgNm;

	//알림내용
	private String alarmCn;

	//알림분류
	private String alarmClsf;

	//알림발신일시
	private String alarmDt;

	//알림확인여부
	private String alarmChkYn;

	//알림연결링크 전사적아이디
	private String alarmLink;

	//알림수신자 리스트
	private List<AlarmRecvVO> alarmRecvVOList;

	private int[] alarmNoArray;	//전체삭제시 알림번호들
}
