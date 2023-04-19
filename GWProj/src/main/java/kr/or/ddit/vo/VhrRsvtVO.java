package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class VhrRsvtVO {
	private String vhrRsvtNo;
	private String vhrNo;
	@JsonProperty("title")
	private String empNo;
	private Date vhrRsvtDt;
	@JsonProperty("start")
	private String vhrRsvtBgngDt;
	@JsonProperty("end")
	private String vhrRsvtEndDt;
	private String vhrRsvtSsts;
}
