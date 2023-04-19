package kr.or.ddit.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
@Data
public class CalVO {
	//일정번호
	@JsonProperty("_id")
	private String calNo;
	//사원번호
	@JsonProperty("userno")
	private String empNo; // 추가필요
	//사원이름
	@JsonProperty("username")
	private String empNm;
	//일정명
	@JsonProperty("title")
	private String calTtl;
	//일정내용
	@JsonProperty("description")
	private String calCn;
	//시작일시
	@JsonProperty("start")
	private String calBgngDt;
	//종료일시
	@JsonProperty("end")
	private String calEndDt;
	//일정장소
	@JsonProperty("place")
	private String calPlc; // 추가필요
	//일정구분
	@JsonProperty("type")
	private String calType;
	//일정색상
	@JsonProperty("backgroundColor")
	private String calCol;
	//글자색상
	@JsonProperty("textColor")
	private String calColTxt;
	//공개여부
	@JsonProperty("calOpen")
	private String calOpenYn; // 추가필요
	//하루종일여부
	@JsonProperty("allDay")
	private String calAllYn;
	
}
