package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//휴가기안서
@Data
public class HoliVO {
	//문서번호
	private String edocNo;
	//기안자
	private String empNo;
	//시작일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date holiBgngYmd;
	//종료일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date holiEndYmd;
	//신청일수
	private int holiAplyCnt;
	//휴가내용
	private String holiCn;
	//휴가분류
	private String holiClsf;
	
}
