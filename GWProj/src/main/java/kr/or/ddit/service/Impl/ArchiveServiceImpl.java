package kr.or.ddit.service.Impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.controller.FileController;
import kr.or.ddit.mapper.ArchiveMapper;
import kr.or.ddit.service.ArchiveService;
import kr.or.ddit.vo.ArchiveVO;
import kr.or.ddit.vo.BookmarkVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Service
public class ArchiveServiceImpl implements ArchiveService {

	@Autowired
	ArchiveMapper archiveMapper;

	public String getFolder(String category) {
		return category+File.separator;
	}

	@Transactional
	@Override
	public int create(ArchiveVO archiveVO) {
		String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";
		String empNo = archiveVO.getEmpNo();
		String category ="";
		String groupNm = archiveVO.getArcGroupNm();

		if(groupNm.equals("ARC0001")) { //개인자료실
			category = "archivce\\personal";
		}

		if(groupNm.equals("ARC0002")) { //부서자료실
			category = "archivce\\dept";
		}

		if(groupNm.equals("ARC0003")) { //공용자료실
			category = "archivce\\public";
		}

		File uploadPath = new File(uploadFolder,getFolder(category));

		//폴더가 없다면 생성
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}

		MultipartFile[] multipartFiles = archiveVO.getUploadFile();
		List<ArchiveVO> archiveVOList = new ArrayList<ArchiveVO>();

		//자료의 개수에 따라 자료실 행 insert하기
		for(MultipartFile file : multipartFiles) {

			ArchiveVO VO = new ArchiveVO();
			String orgName = file.getOriginalFilename();
			String contextType = file.getContentType();
			Long l = file.getSize();
			//파일명 중복 방지
			UUID uuid = UUID.randomUUID();
			//uuid+원본파일명 =>파일네임에 덧씌어주기
			String uploadFileName = uuid.toString() +"_"+orgName;
			File saveFile = new File(uploadPath,uploadFileName);

			try {
				file.transferTo(saveFile);
				try { //만약 image파일이라면 썸내일 지정
					String contentType = Files.probeContentType(saveFile.toPath());
					log.info("contentType : "+contentType);

					if(contentType!=null && contentType.startsWith("image")) {
						FileOutputStream thumbnail = new FileOutputStream(
									new File(uploadPath,"s_"+uploadFileName)
								);
						Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
						thumbnail.close();
					}
				}catch(Exception e) {
					e.printStackTrace();
				}

			}catch(IllegalStateException e) {
				log.error(e.getMessage());
			}catch(IOException e) {
				log.error(e.getMessage());
			}

			String filename= "/" + getFolder(category).replace("\\","/")+uploadFileName;
			VO.setArcGroupNm(groupNm);
			VO.setArcOrgnlNm(orgName);
			VO.setArcFileSz(l.intValue());
			VO.setArcStrgNm(filename);
			VO.setArcType(contextType);
			VO.setArcStrgAddr(uploadPath.toString());
			String thumbFileName =  "/" + getFolder(category).replace("\\","/")+"/"+"s_"+uploadFileName;
			VO.setEmpNo(empNo);
			VO.setArcThumb(thumbFileName);
			archiveVOList.add(VO);
		}

		int result = this.archiveMapper.create(archiveVOList);
		return result;
	}


	@Override
	public int getPersonalTotal(PaginationInfoVO<ArchiveVO> pagingVO) {
		return this.archiveMapper.getPersonalTotal(pagingVO);
	}


	@Override
	public List<Map<String, Object>> getPersonal(PaginationInfoVO<ArchiveVO> pagingVO) {
		return this.archiveMapper.getPersonal(pagingVO);
	}


	@Override
	public int deleteFile(Map<String, Object> map) {
		return this.archiveMapper.deleteFile(map);
	}


	@Override
	public int getPublicTotal(PaginationInfoVO<ArchiveVO> pagingVO) {
		return this.archiveMapper.getPublicTotal(pagingVO);
	}


	@Override
	public List<Map<String, Object>> getPublic(PaginationInfoVO<ArchiveVO> pagingVO) {
		return this.archiveMapper.getPublic(pagingVO);
	}


	@Override
	public int getDeptTotal(PaginationInfoVO<ArchiveVO> pagingVO) {
		return this.archiveMapper.getDeptTotal(pagingVO);
	}


	@Override
	public List<Map<String, Object>> getDept(PaginationInfoVO<ArchiveVO> pagingVO) {
		return this.archiveMapper.getDept(pagingVO);
	}


	@Override
	public int createBookmark(BookmarkVO bookmarkVO) {
		return this.archiveMapper.createBookmark(bookmarkVO);
	}


	@Override
	public int getBookmarkTotal(PaginationInfoVO<ArchiveVO> pagingVO) {
		return this.archiveMapper.getBookmarkTotal(pagingVO);
	}


	@Override
	public List<Map<String, Object>> getBookmark(PaginationInfoVO<ArchiveVO> pagingVO) {
		return this.archiveMapper.getBookmark(pagingVO);
	}


	@Override
	public int deleteBookmark(BookmarkVO bookmarkVO) {
		return this.archiveMapper.deleteBookmark(bookmarkVO);
	}


	@Override
	public int getPersonalUsage(String empNo) {
		return this.archiveMapper.getPersonalUsage(empNo);
	}


	@Override
	public int getpublicUsage() {
		return this.archiveMapper.getpublicUsage();
	}


	@Override
	public int getDeptUsage(String empNo) {
		return this.archiveMapper.getDeptUsage(empNo);
	}


	@Override
	public Map<String, Object> personalImage(Map<String,Object> param) {
		return this.archiveMapper.personalImage(param);
	}


	@Override
	public Map<String, Object> deptImage(String empNo) {
		return this.archiveMapper.deptImage(empNo);
	}


	@Override
	public Map<String, Object> publicImage() {
		return this.archiveMapper.publicImage();
	}


	@Override
	public Map<String, Object> personalDoc(String empNo) {
		return this.archiveMapper.personalDoc(empNo);
	}


	@Override
	public Map<String, Object> deptDoc(String empNo) {
		return this.archiveMapper.deptDoc(empNo);
	}


	@Override
	public Map<String, Object> publicDoc() {
		return this.archiveMapper.publicDoc();
	}


	@Override
	public Map<String, Object> personalMedia(String empNo) {
		return this.archiveMapper.personalMedia(empNo);
	}


	@Override
	public Map<String, Object> deptMedia(String empNo) {
		return this.archiveMapper.deptMedia(empNo);
	}


	@Override
	public Map<String, Object> publictMedia() {
		return this.archiveMapper.publictMedia();
	}

}
