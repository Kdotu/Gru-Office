package kr.or.ddit.service.Impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.controller.FileController;
import kr.or.ddit.mapper.FileMapper;
import kr.or.ddit.mapper.WholBMapper;
import kr.or.ddit.service.WholBService;
import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.FileGrVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.GoodVO;
import kr.or.ddit.vo.WholBVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Service
public class WholBServiceImpl implements WholBService {

	@Autowired
	WholBMapper wholBMapper;
	@Autowired
	FileMapper fileMapper;

	/**
	 * 부서게시글 등록
	 * @param wholBVO
	 * @return int
	 */
	@Override
	public int depBWritePost(WholBVO wholBVO) {

/////////////////////////////////////////////////
//4) 파일업로드
//upload폴더 및 날짜폴더를 만들자
		String uploadFolder = "C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";
		File uploadPath = new File(uploadFolder, FileController.getFolder());
		log.info("uploadPath : " + uploadPath);

//만약 연/월/일 해당 폴더가 없다면
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		MultipartFile[] multipartFiles = wholBVO.getUploadFile();;
		List<FilesVO> filesVOList = new ArrayList<>();

		for (MultipartFile file : multipartFiles) {
			FilesVO vo = new FilesVO();
//1-1)파일그룹INSERT

//원본파일명 및 파일타입 꺼내기
			String originuploadFileName = file.getOriginalFilename();
			String contextType = file.getContentType();

//파일명 중복 방지
			UUID uuid = UUID.randomUUID();

//uuid+원본파일명 =>파일네임에 덧씌어주기
			String uploadFileName = uuid.toString() + "_" + originuploadFileName;

//어디에?무엇을? 계획을 세우자
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				file.transferTo(saveFile);
				try { // 만약 image파일이라면 썸내일을 설정해주자 ..
					String contentType = Files.probeContentType(saveFile.toPath());
					log.info("contentType : " + contentType);

					if (contentType != null && contentType.startsWith("image")) {
						FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
//썸내일 생성
						Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 100, 100);
						thumbnail.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

			} catch (IllegalStateException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			}

			Long l = file.getSize();
//2023/01/30/asdfa_개똥이.jpg
			String filename = "/" + FileController.getFolder().replace("\\", "/") + "/" + uploadFileName;

			vo.setFileOrgnlNm(originuploadFileName);
			vo.setFileStrgAddr(uploadPath.toString());
			vo.setFileStrgNm(filename);
			vo.setFileSz(l.intValue());
			vo.setFileType(contextType);
			String thumbFileName = "/" + FileController.getFolder().replace("\\", "/") + "/" + "s_" + uploadFileName;
			vo.setFileThumb(thumbFileName);

			filesVOList.add(vo);
		}

//FileGrVO객체 생성 및 껍대기 넣어주기+++++
		FileGrVO fileGrVO = new FileGrVO();
		wholBVO.setFileGrVO(fileGrVO);

		wholBVO.getFileGrVO().setFilesList(filesVOList);
		log.info("리스트에 파일이 잘 들어갔을까?" + fileGrVO.getFilesList());

		fileGrVO.setFileGroupNm("전자결재");
//파일그룹 insert
//insert전 fileGrVO : {fileGroupNo:null, fileGroupNm:전자결재, filesList:파일객체들..}
		this.fileMapper.insertFileGr(wholBVO.getFileGrVO());
//insert후 fileGrVO : {fileGroupNo:FILE_GR001, fileGroupNm:전자결재, filesList:파일객체들..}
//이 때 최상위 EdocVO의 fileGroupNo에 FILE_GR001이 채워짐
		log.info("atrzLineInfoVO.getEdocVO().getFileGrVO().getFileGroupNo() : "
				+ wholBVO.getFileGrVO().getFileGroupNo());
		wholBVO.getFileGrVO().setFileGroupNo(wholBVO.getFileGrVO().getFileGroupNo());

		for (FilesVO vo : filesVOList) {
			vo.setFileGroupNo(wholBVO.getFileGrVO().getFileGroupNo());
		}

//파일 insert
		int result55 = fileMapper.insertFiles(filesVOList);
		log.info("result55 : " + result55);

		return wholBMapper.depBWritePost(wholBVO);
	}


	/** 전사게시글 등록
	 * @param wholBVO
	 * @return int
	 */
	@Override
	public int wholBWritePost(WholBVO wholBVO) {
		/////////////////////////////////////////////////
		//4) 파일업로드
		//upload폴더 및 날짜폴더를 만들자
		String uploadFolder = "C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";
		File uploadPath = new File(uploadFolder, FileController.getFolder());
		log.info("uploadPath : " + uploadPath);

		//만약 연/월/일 해당 폴더가 없다면
		if (uploadPath.exists() == false) {
		uploadPath.mkdirs();
		}

		MultipartFile[] multipartFiles = wholBVO.getUploadFile();;
		List<FilesVO> filesVOList = new ArrayList<>();

		for (MultipartFile file : multipartFiles) {
		FilesVO vo = new FilesVO();
		//1-1)파일그룹INSERT

		//원본파일명 및 파일타입 꺼내기
		String originuploadFileName = file.getOriginalFilename();
		String contextType = file.getContentType();

		//파일명 중복 방지
		UUID uuid = UUID.randomUUID();

		//uuid+원본파일명 =>파일네임에 덧씌어주기
		String uploadFileName = uuid.toString() + "_" + originuploadFileName;

		//어디에?무엇을? 계획을 세우자
		File saveFile = new File(uploadPath, uploadFileName);

		try {
		file.transferTo(saveFile);
		try { // 만약 image파일이라면 썸내일을 설정해주자 ..
		String contentType = Files.probeContentType(saveFile.toPath());
		log.info("contentType : " + contentType);

		if (contentType != null && contentType.startsWith("image")) {
		FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
		//썸내일 생성
		Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 100, 100);
		thumbnail.close();
		}
		} catch (Exception e) {
		e.printStackTrace();
		}

		} catch (IllegalStateException e) {
		log.error(e.getMessage());
		} catch (IOException e) {
		log.error(e.getMessage());
		}

		Long l = file.getSize();
		//2023/01/30/asdfa_개똥이.jpg
		String filename = "/" + FileController.getFolder().replace("\\", "/") + "/" + uploadFileName;

		vo.setFileOrgnlNm(originuploadFileName);
		vo.setFileStrgAddr(uploadPath.toString());
		vo.setFileStrgNm(filename);
		vo.setFileSz(l.intValue());
		vo.setFileType(contextType);
		String thumbFileName = "/" + FileController.getFolder().replace("\\", "/") + "/" + "s_" + uploadFileName;
		vo.setFileThumb(thumbFileName);

		filesVOList.add(vo);
		}

		//FileGrVO객체 생성 및 껍대기 넣어주기+++++
		FileGrVO fileGrVO = new FileGrVO();
		wholBVO.setFileGrVO(fileGrVO);

		wholBVO.getFileGrVO().setFilesList(filesVOList);
		log.info("리스트에 파일이 잘 들어갔을까?" + fileGrVO.getFilesList());

		fileGrVO.setFileGroupNm("전자결재");
		//파일그룹 insert
		//insert전 fileGrVO : {fileGroupNo:null, fileGroupNm:전자결재, filesList:파일객체들..}
		this.fileMapper.insertFileGr(wholBVO.getFileGrVO());
		//insert후 fileGrVO : {fileGroupNo:FILE_GR001, fileGroupNm:전자결재, filesList:파일객체들..}
		//이 때 최상위 EdocVO의 fileGroupNo에 FILE_GR001이 채워짐
		log.info("atrzLineInfoVO.getEdocVO().getFileGrVO().getFileGroupNo() : "
		+ wholBVO.getFileGrVO().getFileGroupNo());
		wholBVO.getFileGrVO().setFileGroupNo(wholBVO.getFileGrVO().getFileGroupNo());

		for (FilesVO vo : filesVOList) {
		vo.setFileGroupNo(wholBVO.getFileGrVO().getFileGroupNo());
		}

		//파일 insert
		int result55 = fileMapper.insertFiles(filesVOList);
		log.info("result55 : " + result55);

		return wholBMapper.wholBWritePost(wholBVO);
	}

	/** 전사게시글 목록
	 * @param wholBVO
	 * @return List<WholBVO>
	 */
	@Override
	public List<WholBVO> wholBList(WholBVO wholBVO){
		return wholBMapper.wholBList(wholBVO);
	}

	/** 전사게시글 상세보기
	 * @param wholBVO
	 * @return WholBVO
	 */
	@Override
	public WholBVO wholBDetail(String wholBbsNo) {
		int increment = wholBMapper.increment(wholBbsNo);

		//WholBVO(wholBbsNo=49, empNo=202304, rnum=0, empNm=null, bbsClsfNo=null, fileGroupNo=null, wholBbsTtl=null, wholBbsCn=null, wholBbsRegYmd=null, wholBbsInqCnt=0, cntGood=0, boardCmntList=null, uploadFile=null, fileGrVO=null)
		log.info("wholBVO 증가 : " + wholBbsNo);

		//empNo, wholBbsNo
		log.info("incrementincrement : "+ increment);

		WholBVO wholBVO = wholBMapper.wholBDetail(wholBbsNo);
		
		//List<FilesVO> filesVOList = this.fileMapper.getFilesList(wholBVO.getFileGroupNo());
		log.info("wholBVO(개똥이) : " + wholBVO);
		
		//wholBVO.setFilesVOList(filesVOList);
		
		return wholBVO;
	}

	/** 좋아요 기능
	 * @param goodVO
	 * @return int
	 */
	@Override
	public int wholBLikeUp(GoodVO goodVO){
		//1.좋아요 클릭 확인
		int result = wholBMapper.selectCnt(goodVO);
		log.info("selectCnt : " + result);

		if(result == 0) {//2.없으면 insert
			wholBMapper.insertGood(goodVO);
			result = 1;
		}else {//3.있으면 delete
			wholBMapper.deleteGood(goodVO);
			result = -1;
		}
		log.info("result impl : " + result);

		return result;
	}

	/** 전사게시글 삭제
	 * @param wholBVO
	 * @return int
	 */
	@Override
	public int delWholB(WholBVO wholBVO) {
		return wholBMapper.delWholB(wholBVO);
	}

	/** 내가 쓴 글 받아오기
	 * @param wholBVO
	 * @return List<WholBVO>
	 */
	@Override
	public List<WholBVO> selMyBList(WholBVO wholBVO){
		return wholBMapper.selMyBList(wholBVO);
	}

	/** 댓글 등록
	 * @param wholBVO
	 * @return int
	 */
	@Override
	public int createCmnt(CmntVO CmntVO) {
		return wholBMapper.createCmnt(CmntVO);
	}

	/** 댓글 수정
	 * @param cmntVO
	 * @return int
	 */
	@Override
	public int updateCmnt(CmntVO cmntVO) {
		return wholBMapper.updateCmnt(cmntVO);
	}

	/** 댓글 삭제
	 * @param cmntCn
	 * @return int
	 */
	@Override
	public int deleteCmnt(CmntVO cmntVO) {
		return wholBMapper.deleteCmnt(cmntVO);
	}

	/** 댓글 수 조회
	 * @param wholBVO
	 * @return int
	 */
	@Override
	public int cmntCnt(WholBVO wholBVO) {
		return wholBMapper.cmntCnt(wholBVO);
	}

	/** 부서게시글 목록 조회
	 * @param wholBVO
	 * @return List<WholBVO>
	 */
	@Override
	public List<WholBVO> depBList(WholBVO wholBVO){
		return wholBMapper.depBList(wholBVO);
	}

	/** 공지게시글 목록 조회
	 * @param wholBVO
	 * @return List<WholBVO>
	 */
	@Override
	public List<WholBVO> noticeBList(){
		return wholBMapper.noticeBList();
	}

	
	
//	@Override
//	public WholBVO wholBDetail(WholBVO wholBVO) {
//		int increment = wholBMapper.increment(wholBVO);
//
//		//WholBVO(wholBbsNo=49, empNo=202304, rnum=0, empNm=null, bbsClsfNo=null, fileGroupNo=null, wholBbsTtl=null, wholBbsCn=null, wholBbsRegYmd=null, wholBbsInqCnt=0, cntGood=0, boardCmntList=null, uploadFile=null, fileGrVO=null)
//		log.info("wholBVO 증가 : " + wholBVO);
//
//		//empNo, wholBbsNo
//		log.info("incrementincrement : "+ increment);
//
//		wholBVO = wholBMapper.wholBDetail(wholBVO);
//
//		log.info("wholBVO(개똥이) : " + wholBVO);
//
//		return wholBVO;
//	}
//	
	
	
	/** 공지 상세보기 조회
	 * @param wholBbsNo
	 * @return WholBVO
	 */
	@Override
	public WholBVO noticeBDetail(String wholBbsNo) {
		int incrementNt = wholBMapper.increment(wholBbsNo);
		log.info("incrementNt ㅋㅋ: " + incrementNt);
		WholBVO wholBVO = wholBMapper.noticeBDetail(wholBbsNo);
		log.info("wholBbsNo ㅋㅋ: " + wholBbsNo);		
		
		return wholBVO;
	}

	/** 공지게시글 등록
	 * @param wholBVO
	 * @return int
	 */
	@Override
	public int noticeBWritePost(WholBVO wholBVO) {
		return wholBMapper.noticeBWritePost(wholBVO);
	}


	@Override
	public List<WholBVO> mainNotice() {
		return wholBMapper.mainNotice();
	}


	@Override
	public List<WholBVO> mainWhole() {
		return wholBMapper.mainWhole();
	}


	@Override
	public List<WholBVO> mainDept(String username) {
		return wholBMapper.mainDept(username);
	}


	@Override
	public String getDeptNm(String username) {
		return wholBMapper.getDeptNm(username);
	}


	@Override
	public int wholBModify(WholBVO wholBVO) {
		return this.wholBMapper.wholBModify(wholBVO);
	}
	
	/** 기본키로 게시글 한 행 가져오기
	 * @param wholBVO
	 * @return WholBVO
	 */
	@Override
	public WholBVO selectLow(WholBVO wholBVO) {
		return this.wholBMapper.selectLow(wholBVO);
	}
	
	/** 전사게시글 수정
	 * @param wholBVO
	 * @return int
	 */
	public int wholBModi(WholBVO wholBVO) {
		return this.wholBMapper.wholBModi(wholBVO);
	}
	
	/** 좋아요 클릭 조회
	 * @param wholBVO
	 * @return int
	 */
	public int selectCnt(GoodVO goodVO) {
		log.info("goodVO 바보 :"+ goodVO);
		
		return this.wholBMapper.selectCnt(goodVO);
	}


}
