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
import kr.or.ddit.service.FileService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FileGrVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.MailVO;
import kr.or.ddit.vo.SrvyVO;
import kr.or.ddit.vo.TaskVO;
import kr.or.ddit.vo.VhrVO;
import kr.or.ddit.vo.WholBVO;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Log
@Service
public class FileServiceImpl implements FileService {

	@Autowired
	FileMapper fileMapper;

	/** =========== 회원프로필사진 파일 업로드 ============
	 * 파일 변수를 가진 VO객체를 입력받아 업로드 진행.
	 */
	@Override
	public int filecreate(EmpVO empVO) {
			//4) 파일업로드
			//upload폴더 및 날짜폴더를 만들자
			String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";

			String usage="emp/profile";

			File uploadPath = new File(uploadFolder,getFolderUsage(usage,empVO.getEmpNo()));


			//만약 연/월/일 해당 폴더가 없다면
			if(uploadPath.exists()==false) {
				uploadPath.mkdirs();
			}

			MultipartFile[] multipartFiles = empVO.getUploadFile();

			List<FilesVO> filesVOList = new ArrayList<>();

			for(MultipartFile file : multipartFiles) {
				FilesVO vo = new FilesVO();
				//1-1)파일그룹INSERT

				//원본파일명 및 파일타입 꺼내기
				String originuploadFileName = file.getOriginalFilename();
				String contextType = file.getContentType();

				//파일명 중복 방지
				UUID uuid = UUID.randomUUID();

				//uuid+원본파일명 =>파일네임에 덧씌어주기
				String uploadFileName = uuid.toString() +"_"+originuploadFileName;

				//어디에?무엇을? 계획을 세우자
				File saveFile = new File(uploadPath,uploadFileName);

				try {
					file.transferTo(saveFile);
					try { //만약 image파일이라면 썸내일을 설정해주자 ..
						String contentType = Files.probeContentType(saveFile.toPath());
						log.info("contentType : "+contentType);

						if(contentType!=null && contentType.startsWith("image")) {
							FileOutputStream thumbnail = new FileOutputStream(
										new File(uploadPath,"s_"+uploadFileName)
									);
							//썸내일 생성
							Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
							thumbnail.close();
						}
					}catch(Exception e) {
						e.printStackTrace();
					}

				}catch(IllegalStateException e) {
					log.info(e.getMessage());
				}catch(IOException e) {
					log.info(e.getMessage());
				}

				Long l = file.getSize();
				//2023/01/30/asdfa_개똥이.jpg
				String filename= "/" + getFolderUsage(usage,empVO.getEmpNo()).replace("\\","/")+"/"+uploadFileName;

				vo.setFileOrgnlNm(originuploadFileName);
				vo.setFileStrgAddr(uploadPath.toString());
				vo.setFileStrgNm(filename);
				vo.setFileSz(l.intValue());
				vo.setFileType(contextType);
				String thumbFileName =  "/" + getFolderUsage(usage,empVO.getEmpNo()).replace("\\","/")+"/"+"s_"+uploadFileName;
				vo.setFileThumb(thumbFileName);

				filesVOList.add(vo);
	 		}

			FileGrVO fileGrVO = new FileGrVO();
			empVO.setFileGrVO(fileGrVO);

			empVO.getFileGrVO().setFilesList(filesVOList);

			empVO.getFileGrVO().setFileGroupNm("회원프로필");
			//파일그룹 insert
			//insert전 fileGrVO : {fileGroupNo:null, fileGroupNm:전자결재, filesList:파일객체들..}
			this.fileMapper.insertFileGr(empVO.getFileGrVO());
			//insert후 fileGrVO : {fileGroupNo:FILE_GR001, fileGroupNm:전자결재, filesList:파일객체들..}
			//이 때 최상위 EdocVO의 fileGroupNo에 FILE_GR001이 채워짐
			log.info("empVO.getFileGrVO().getFileGroupNo() : " + empVO.getFileGrVO().getFileGroupNo());
			empVO.setFileGroupNo(empVO.getFileGrVO().getFileGroupNo());

			for(FilesVO vo : filesVOList) {
				vo.setFileGroupNo(empVO.getFileGrVO().getFileGroupNo());
			}

			//파일 insert
			int result = fileMapper.insertFiles(filesVOList);
			log.info("result : " + result);
			return result;
	}

	//=========== 태스크 파일 업로드 ============
	@Override
	public int taskFilecreate(TaskVO taskVO) {
		//4) 파일업로드
		//upload폴더 및 날짜폴더를 만들자
		String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";

		String usage="task";

		File uploadPath = new File(uploadFolder,getFolderUsage(usage,taskVO.getTaskNo()));


		//만약 연/월/일 해당 폴더가 없다면
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}

		MultipartFile[] multipartFiles = taskVO.getUploadFile();

		List<FilesVO> filesVOList = new ArrayList<>();

		for(MultipartFile file : multipartFiles) {
			FilesVO vo = new FilesVO();
			//1-1)파일그룹INSERT

			//원본파일명 및 파일타입 꺼내기
			String originuploadFileName = file.getOriginalFilename();
			String contextType = file.getContentType();

			//파일명 중복 방지
			UUID uuid = UUID.randomUUID();

			//uuid+원본파일명 =>파일네임에 덧씌어주기
			String uploadFileName = uuid.toString() +"_"+originuploadFileName;

			//어디에?무엇을? 계획을 세우자
			File saveFile = new File(uploadPath,uploadFileName);

			try {
				file.transferTo(saveFile);
				try { //만약 image파일이라면 썸내일을 설정해주자 ..
					String contentType = Files.probeContentType(saveFile.toPath());
					log.info("contentType : "+contentType);

					if(contentType!=null && contentType.startsWith("image")) {
						FileOutputStream thumbnail = new FileOutputStream(
									new File(uploadPath,"s_"+uploadFileName)
								);
						//썸내일 생성
						Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
						thumbnail.close();
					}
				}catch(Exception e) {
					e.printStackTrace();
				}

			}catch(IllegalStateException e) {
				log.info(e.getMessage());
			}catch(IOException e) {
				log.info(e.getMessage());
			}

			Long l = file.getSize();
			//2023/01/30/asdfa_개똥이.jpg
			String filename= "/" + getFolderUsage(usage,taskVO.getTaskNo()).replace("\\","/")+"/"+uploadFileName;

			vo.setFileOrgnlNm(originuploadFileName);
			vo.setFileStrgAddr(uploadPath.toString());
			vo.setFileStrgNm(filename);
			vo.setFileSz(l.intValue());
			vo.setFileType(contextType);
			String thumbFileName =  "/" + getFolderUsage(usage,taskVO.getTaskNo()).replace("\\","/")+"/"+"s_"+uploadFileName;
			vo.setFileThumb(thumbFileName);

			filesVOList.add(vo);
 		}

		//FileGrVO객체 생성 및 껍대기 넣어주기
		FileGrVO fileGrVO = new FileGrVO();
		taskVO.setFileGrVO(fileGrVO);

		taskVO.getFileGrVO().setFilesList(filesVOList);
		log.info("리스트에 파일이 잘 들어갔을까?"+taskVO.getFileGrVO().getFilesList());

		taskVO.getFileGrVO().setFileGroupNm("태스크파일");
		//파일그룹 insert
		//insert전 fileGrVO : {fileGroupNo:null, fileGroupNm:전자결재, filesList:파일객체들..}
		this.fileMapper.insertFileGr(taskVO.getFileGrVO());
		//insert후 fileGrVO : {fileGroupNo:FILE_GR001, fileGroupNm:전자결재, filesList:파일객체들..}
		//이 때 최상위 EdocVO의 fileGroupNo에 FILE_GR001이 채워짐
		log.info("empVO.getFileGrVO().getFileGroupNo() : " + taskVO.getFileGrVO().getFileGroupNo());
		taskVO.setFileGroupNo(taskVO.getFileGrVO().getFileGroupNo());

		for(FilesVO vo : filesVOList) {
			vo.setFileGroupNo(taskVO.getFileGrVO().getFileGroupNo());
		}

		//파일 insert
		int result = fileMapper.insertFiles(filesVOList);
		log.info("result : " + result);
		return result;
	}

	//=========== 설문조사 파일 업로드 ============
	@Override
	public int srvyFileCreate(SrvyVO srvyVO) {
		// 설문조사 파일업로드
		//upload폴더 및 날짜폴더를 만들자
		String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";

		String usage="srvy";
		File uploadPath = new File(uploadFolder,getFolderUsage(usage,srvyVO.getSrvyNo()));

		//만약 연/월/일 해당 폴더가 없다면
		if(uploadPath.exists()==false) { uploadPath.mkdirs(); }

		MultipartFile[] multipartFiles = srvyVO.getUploadFile();
		List<FilesVO> filesVOList = new ArrayList<>();

		for(MultipartFile file : multipartFiles) {
			FilesVO vo = new FilesVO();
			//1-1)파일그룹INSERT

			//원본파일명 및 파일타입 꺼내기
			String originuploadFileName = file.getOriginalFilename();
			String contextType = file.getContentType();

			//파일명 중복 방지
			UUID uuid = UUID.randomUUID();

			//uuid+원본파일명 =>파일네임에 덧씌어주기
			String uploadFileName = uuid.toString() +"_"+originuploadFileName;

			//어디에?무엇을? 계획을 세우자
			File saveFile = new File(uploadPath,uploadFileName);

			try {
				file.transferTo(saveFile);
				try { //만약 image파일이라면 썸내일을 설정해주자 ..
					String contentType = Files.probeContentType(saveFile.toPath());

					if(contentType!=null && contentType.startsWith("image")) {
						FileOutputStream thumbnail = new FileOutputStream(
									new File(uploadPath,"s_"+uploadFileName)
								);
						//썸내일 생성
						Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
						thumbnail.close();
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}catch(IllegalStateException e) {
				log.info(e.getMessage());
			}catch(IOException e) {
				log.info(e.getMessage());
			}

			Long l = file.getSize();
			//2023/01/30/asdfa_개똥이.jpg
			String filename= "/" + getFolderUsage(usage,srvyVO.getSrvyNo()).replace("\\","/")+"/"+uploadFileName;

			vo.setFileOrgnlNm(originuploadFileName);
			vo.setFileStrgAddr(uploadPath.toString());
			vo.setFileStrgNm(filename);
			vo.setFileSz(l.intValue());
			vo.setFileType(contextType);
			String thumbFileName =  "/" + getFolderUsage(usage,srvyVO.getSrvyNo()).replace("\\","/")+"/"+"s_"+uploadFileName;
			vo.setFileThumb(thumbFileName);

			filesVOList.add(vo);
 		}

		//FileGrVO객체 생성 및 껍대기 넣어주기
		FileGrVO fileGrVO = new FileGrVO();
		srvyVO.setFileGrVO(fileGrVO);

		srvyVO.getFileGrVO().setFilesList(filesVOList);
		log.info("리스트에 파일이 잘 들어갔을까?"+srvyVO.getFileGrVO().getFilesList());

		srvyVO.getFileGrVO().setFileGroupNm("설문조사");
		//파일그룹 insert
		//insert전 fileGrVO : {fileGroupNo:null, fileGroupNm:전자결재, filesList:파일객체들..}
		this.fileMapper.insertFileGr(srvyVO.getFileGrVO());
		//insert후 fileGrVO : {fileGroupNo:FILE_GR001, fileGroupNm:전자결재, filesList:파일객체들..}
		//이 때 최상위 EdocVO의 fileGroupNo에 FILE_GR001이 채워짐
		log.info("srvyVO.getFileGrVO().getFileGroupNo() : " + srvyVO.getFileGrVO().getFileGroupNo());
		srvyVO.setFileGroupNo(srvyVO.getFileGrVO().getFileGroupNo());

		for(FilesVO vo : filesVOList) {
			vo.setFileGroupNo(srvyVO.getFileGrVO().getFileGroupNo());
		}

		//파일 insert
		int result = fileMapper.insertFiles(filesVOList);
		log.info("result : " + result);
		return result;
	}



	//=========== 차량 파일 업로드 ============
	@Override
	public int vhrFileCreate(VhrVO vhrVO) {
		// 차량 파일업로드
		//upload폴더 및 날짜폴더를 만들자
		String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";

		String usage="vhr";
		File uploadPath = new File(uploadFolder,getFolderUsage(usage,vhrVO.getVhrNo()));

		//만약 연/월/일 해당 폴더가 없다면
		if(uploadPath.exists()==false) { uploadPath.mkdirs(); }

		MultipartFile[] multipartFiles = vhrVO.getUploadFile();
		List<FilesVO> filesVOList = new ArrayList<>();

		for(MultipartFile file : multipartFiles) {
			FilesVO vo = new FilesVO();
			//1-1)파일그룹INSERT

			//원본파일명 및 파일타입 꺼내기
			String originuploadFileName = file.getOriginalFilename();
			String contextType = file.getContentType();

			//파일명 중복 방지
			UUID uuid = UUID.randomUUID();

			//uuid+원본파일명 =>파일네임에 덧씌어주기
			String uploadFileName = uuid.toString() +"_"+originuploadFileName;

			//어디에?무엇을? 계획을 세우자
			File saveFile = new File(uploadPath,uploadFileName);

			try {
				file.transferTo(saveFile);
				try { //만약 image파일이라면 썸네일을 설정해주자 ..
					String contentType = Files.probeContentType(saveFile.toPath());

					if(contentType!=null && contentType.startsWith("image")) {
						FileOutputStream thumbnail = new FileOutputStream(
								new File(uploadPath,"s_"+uploadFileName)
								);
						//썸네일 생성
						Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
						thumbnail.close();
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}catch(IllegalStateException e) {
				log.info(e.getMessage());
			}catch(IOException e) {
				log.info(e.getMessage());
			}

			Long l = file.getSize();
			//2023/01/30/asdfa_개똥이.jpg
			String filename= "/" + getFolderUsage(usage,vhrVO.getVhrNo()).replace("\\","/")+"/"+uploadFileName;

			vo.setFileOrgnlNm(originuploadFileName);
			vo.setFileStrgAddr(uploadPath.toString());
			vo.setFileStrgNm(filename);
			vo.setFileSz(l.intValue());
			vo.setFileType(contextType);
			String thumbFileName =  "/" + getFolderUsage(usage,vhrVO.getVhrNo()).replace("\\","/")+"/"+"s_"+uploadFileName;
			vo.setFileThumb(thumbFileName);

			filesVOList.add(vo);
		}

		//FileGrVO객체 생성 및 껍데기 넣어주기
		FileGrVO fileGrVO = new FileGrVO();
		vhrVO.setFileGrVO(fileGrVO);

		vhrVO.getFileGrVO().setFilesList(filesVOList);
		log.info("리스트에 파일이 잘 들어갔을까?"+vhrVO.getFileGrVO().getFilesList());

		vhrVO.getFileGrVO().setFileGroupNm("차량");
		//파일그룹 insert
		//insert전 fileGrVO : {fileGroupNo:null, fileGroupNm:전자결재, filesList:파일객체들..}
		this.fileMapper.insertFileGr(vhrVO.getFileGrVO());
		//insert후 fileGrVO : {fileGroupNo:FILE_GR001, fileGroupNm:전자결재, filesList:파일객체들..}
		//이 때 최상위 EdocVO의 fileGroupNo에 FILE_GR001이 채워짐
		log.info("srvyVO.getFileGrVO().getFileGroupNo() : " + vhrVO.getFileGrVO().getFileGroupNo());
		vhrVO.setFileGroupNo(vhrVO.getFileGrVO().getFileGroupNo());

		for(FilesVO vo : filesVOList) {
			vo.setFileGroupNo(vhrVO.getFileGrVO().getFileGroupNo());
		}

		//파일 insert

		log.info("리스트에 파일이 잘 들어갔을까? filesVOList==> " + filesVOList);
		int result = fileMapper.insertFiles(filesVOList);
		log.info("result : " + result);
		return result;
	}


	/**
	 * usage : 사용처 (ex.emp, srvy,..)
	 * key : 사용처에 들어가는 키값 (사원번호, 프로젝트 번호,..)
	 * @param usage
	 * @param key
	 * @return
	 */
	public String getFolderUsage(String usage, String key) {
		return usage + File.separator + key;
	}

	@Override
	public List<FilesVO> getFilesList(String fileGrNo) {
		return this.fileMapper.getFilesList(fileGrNo);
	}

	@Override
	public int BoardFileCreate(WholBVO wholBVO) {
		log.info("BoardFileCreate->wholBVO : " + wholBVO);
		// 게시판 파일업로드
		//upload폴더 및 날짜폴더를 만들자
		String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";

		String usage="board";
		File uploadPath = new File(uploadFolder,getFolderUsage(usage,wholBVO.getWholBbsNo()));

		//만약 연/월/일 해당 폴더가 없다면
		if(uploadPath.exists()==false) { uploadPath.mkdirs(); }

		MultipartFile[] multipartFiles = wholBVO.getUploadFile();
		List<FilesVO> filesVOList = new ArrayList<>();

		for(MultipartFile file : multipartFiles) {
			FilesVO vo = new FilesVO();
			//1-1)파일그룹INSERT

			//원본파일명 및 파일타입 꺼내기
			String originuploadFileName = file.getOriginalFilename();
			String contextType = file.getContentType();

			//파일명 중복 방지
			UUID uuid = UUID.randomUUID();

			//uuid+원본파일명 =>파일네임에 덧씌어주기
			String uploadFileName = uuid.toString() +"_"+originuploadFileName;

			//어디에?무엇을? 계획을 세우자
			File saveFile = new File(uploadPath,uploadFileName);

			try {
				file.transferTo(saveFile);
				try { //만약 image파일이라면 썸네일을 설정해주자 ..
					String contentType = Files.probeContentType(saveFile.toPath());

					if(contentType!=null && contentType.startsWith("image")) {
						FileOutputStream thumbnail = new FileOutputStream(
								new File(uploadPath,"s_"+uploadFileName)
								);
						//썸네일 생성
						Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
						thumbnail.close();
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}catch(IllegalStateException e) {
				log.info(e.getMessage());
			}catch(IOException e) {
				log.info(e.getMessage());
			}

			Long l = file.getSize();
			//2023/01/30/asdfa_개똥이.jpg
			String filename= "/" + getFolderUsage(usage,wholBVO.getWholBbsNo()).replace("\\","/")+"/"+uploadFileName;

			vo.setFileOrgnlNm(originuploadFileName);
			vo.setFileStrgAddr(uploadPath.toString());
			vo.setFileStrgNm(filename);
			vo.setFileSz(l.intValue());
			vo.setFileType(contextType);
			String thumbFileName =  "/" + getFolderUsage(usage,wholBVO.getWholBbsNo()).replace("\\","/")+"/"+"s_"+uploadFileName;
			vo.setFileThumb(thumbFileName);

			filesVOList.add(vo);
		}

		//FileGrVO객체 생성 및 껍데기 넣어주기
		FileGrVO fileGrVO = new FileGrVO();
		wholBVO.setFileGrVO(fileGrVO);

		wholBVO.getFileGrVO().setFilesList(filesVOList);
		log.info("리스트에 파일이 잘 들어갔을까?"+wholBVO.getFileGrVO().getFilesList());

		wholBVO.getFileGrVO().setFileGroupNm("게시판");
		//파일그룹 insert
		//insert전 fileGrVO : {fileGroupNo:null, fileGroupNm:전자결재, filesList:파일객체들..}
		this.fileMapper.insertFileGr(wholBVO.getFileGrVO());
		//insert후 fileGrVO : {fileGroupNo:FILE_GR001, fileGroupNm:전자결재, filesList:파일객체들..}
		//이 때 최상위 EdocVO의 fileGroupNo에 FILE_GR001이 채워짐
		log.info("srvyVO.getFileGrVO().getFileGroupNo() : " + wholBVO.getFileGrVO().getFileGroupNo());
		wholBVO.setFileGroupNo(wholBVO.getFileGrVO().getFileGroupNo());

		for(FilesVO vo : filesVOList) {
			vo.setFileGroupNo(wholBVO.getFileGrVO().getFileGroupNo());
		}
		//파일 insert

		log.info("리스트에 파일이 잘 들어갔을까? filesVOList==> " + filesVOList);
		int result = fileMapper.insertFiles(filesVOList);
		log.info("result : " + result);
		return result;
	}

	@Override
	public int MailFileCreate(MailVO mailVO) {
		// 메일 파일업로드
		//upload폴더 및 날짜폴더를 만들자
		String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";

		String usage="mail";
		File uploadPath = new File(uploadFolder,getFolderUsage(usage,mailVO.getEmlNo()));

		//만약 연/월/일 해당 폴더가 없다면
		if(uploadPath.exists()==false) { uploadPath.mkdirs(); }

		MultipartFile[] multipartFiles = mailVO.getUploadFile();
		List<FilesVO> filesVOList = new ArrayList<>();

		for(MultipartFile file : multipartFiles) {
			FilesVO vo = new FilesVO();
			//1-1)파일그룹INSERT

			//원본파일명 및 파일타입 꺼내기
			String originuploadFileName = file.getOriginalFilename();
			if("".equals(originuploadFileName)) {
				continue;
			}
			String contextType = file.getContentType();

			//파일명 중복 방지
			UUID uuid = UUID.randomUUID();

			//uuid+원본파일명 =>파일네임에 덧씌어주기
			String uploadFileName = uuid.toString() +"_"+originuploadFileName;

			//어디에?무엇을? 계획을 세우자
			File saveFile = new File(uploadPath,uploadFileName);

			try {
				file.transferTo(saveFile);
				try { //만약 image파일이라면 썸네일을 설정해주자 ..
					String contentType = Files.probeContentType(saveFile.toPath());

					if(contentType!=null && contentType.startsWith("image")) {
						FileOutputStream thumbnail = new FileOutputStream(
								new File(uploadPath,"s_"+uploadFileName)
								);
						//썸네일 생성
						Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
						thumbnail.close();
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}catch(IllegalStateException e) {
				log.info(e.getMessage());
			}catch(IOException e) {
				log.info(e.getMessage());
			}

			Long l = file.getSize();
			//2023/01/30/asdfa_개똥이.jpg
			String filename= "/" + getFolderUsage(usage,mailVO.getEmlNo()).replace("\\","/")+"/"+uploadFileName;

			vo.setFileOrgnlNm(originuploadFileName);
			vo.setFileStrgAddr(uploadPath.toString());
			vo.setFileStrgNm(filename);
			vo.setFileSz(l.intValue());
			vo.setFileType(contextType);
			String thumbFileName =  "/" + getFolderUsage(usage,mailVO.getEmlNo()).replace("\\","/")+"/"+"s_"+uploadFileName;
			vo.setFileThumb(thumbFileName);

			filesVOList.add(vo);
		}

		if(filesVOList.size()==0) {
			return 0;
		}
		//FileGrVO객체 생성 및 껍데기 넣어주기
		FileGrVO fileGrVO = new FileGrVO();
		mailVO.setFileGrVO(fileGrVO);

		mailVO.getFileGrVO().setFilesList(filesVOList);
		log.info("리스트에 파일이 잘 들어갔을까?"+mailVO.getFileGrVO().getFilesList());

		mailVO.getFileGrVO().setFileGroupNm("메일");
		//파일그룹 insert
		//insert전 fileGrVO : {fileGroupNo:null, fileGroupNm:전자결재, filesList:파일객체들..}
		this.fileMapper.insertFileGr(mailVO.getFileGrVO());
		//insert후 fileGrVO : {fileGroupNo:FILE_GR001, fileGroupNm:전자결재, filesList:파일객체들..}
		//이 때 최상위 EdocVO의 fileGroupNo에 FILE_GR001이 채워짐
		log.info("srvyVO.getFileGrVO().getFileGroupNo() : " + mailVO.getFileGrVO().getFileGroupNo());
		mailVO.setFileGroupNo(mailVO.getFileGrVO().getFileGroupNo());

		for(FilesVO vo : filesVOList) {
			vo.setFileGroupNo(mailVO.getFileGrVO().getFileGroupNo());
		}
		//파일 insert

		log.info("리스트에 파일이 잘 들어갔을까? filesVOList==> " + filesVOList);
		int result = fileMapper.insertFiles(filesVOList);
		log.info("result : " + result);
		return result;
	}
}
