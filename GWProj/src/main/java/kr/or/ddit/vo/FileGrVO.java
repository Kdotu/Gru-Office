package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FileGrVO {
	private String fileGroupNo;
	private String fileGroupNm;
	
	private List<FilesVO> filesList;
}
