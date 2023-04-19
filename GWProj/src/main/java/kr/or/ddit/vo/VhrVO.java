package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class VhrVO {
	private String vhrNo;
	private String vhrNm;
	private String vhrCmp;
	private String vhrRegNo;
	private String vhrSort;
	private String vhrSz;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date vhrRegDt;
	private String vhrFuel;
	private String vhrInfo;
	private String fileGroupNo;
	//파일
	private MultipartFile[] uploadFile;
	//첨부파일 그룹번호
	private FileGrVO fileGrVO;
	
	
}
