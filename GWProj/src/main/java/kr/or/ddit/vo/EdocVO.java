package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EdocVO {
	//문서번호
	private String edocNo;
	//사원번호
	private String empNo;
	//참조문서번호
	private String edocRefNo;
	//결재선정보번호
	private String atrzLineInfoNo;
	//첨부파일그룹번호
	private String fileGroupNo;
	//문서제목
	private String edocTtl;
	//기안일시
	private Date edocDt;
	//총결여부
	private String edocLastAtrzYn;
	//문서양식분류
	private String edocFormClsf;

	//파일
	private MultipartFile[] uploadFile;

	//첨부파일 그룹번호
	private FileGrVO fileGrVO;

	//전자문서 공통 : 휴가기안서 = 1 : 1
	private HoliVO holiVO;

	private DrftVO dfrtVO;
}
