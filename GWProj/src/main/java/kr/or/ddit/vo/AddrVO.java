package kr.or.ddit.vo;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.validation.annotation.Validated;

import lombok.Data;

@Data
public class AddrVO {
	private int addrNo;//주소록번호
	private String empNo;//사원번호	
	
	private String addrNm;//이름
	private String emlAddr;//이메일
	@NotBlank
//	@Pattern(regexp="^01(?:0|1[6-9])[.-]?(\\d{3}|\\d{4})[.-]?(\\d{4})$")
	@Pattern(regexp="^(01[167890])-(\\d{3,4})-(\\d{4})$", message = "연락처 전화번호 정보가 잘못되었습니다.")
	private String addrHp;//연락처
	private String addrCoNm;//회사명
	
	//우편번호
	private String postno;
	//주소
	private String cusAddr;
	//상세주소
	private String addrDet;
	
	
//	private String addrCo;//회사주소
	
	
	
	private String addrRank;//직급
	private String addrDept;//부서
	private String addrCoTelno;//회사전화번호
	
	private String bookmarkNo;//즐겨찾기번호	
	
	private int[] addrNoArray;	//체크박스된 주소록 번호들

}
