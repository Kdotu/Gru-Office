package kr.or.ddit.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class AuthrtVO implements Serializable {
	private String authrtNo;
	private String empNo;
	private String authrtNm;
}
