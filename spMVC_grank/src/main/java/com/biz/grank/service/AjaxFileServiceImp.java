package com.biz.grank.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.grank.domain.BoardDto;
import com.biz.grank.domain.FileDto;
import com.biz.grank.persistence.FileDao;

@Service
public class AjaxFileServiceImp implements AjaxFileService {

	@Autowired
	SqlSession sqlSession;
	
	FileDao fDao;
	
	@Autowired
	public void getMapper() {
		fDao = sqlSession.getMapper(FileDao.class);
	}
	
	private final String upLoadFolder = "c:/bizwork/upload";
	
	@Override
	public List<FileDto> upLoads(MultipartHttpServletRequest files) {
		// TODO Auto-generated method stub
		List<MultipartFile> fileList = files.getFiles("files");
		List<FileDto> fileDtoList = new ArrayList<FileDto>();
		for(MultipartFile file : fileList) {
			
			String saveName = this.upLoad(file);
			
			fileDtoList.add(FileDto.builder()
			.origin_name(file.getOriginalFilename())
			.file_name(saveName).build());
		
		}
		return fileDtoList;
	}

	public String upLoad(MultipartFile file) {
		// TODO Auto-generated method stub
		// 업로드할 파일 정보가 없으면
		// 더이상 코드 진행x
		if(file.isEmpty() || file ==null) return null;
		// 파일의 원본이름
		String originName = file.getOriginalFilename();
		// UUID값 생성
		String uuString = UUID.randomUUID().toString();
		// 파일의 저장할 이름(UUID + _ + 원본이름)
		String saveName = uuString + "_" + originName;
		//파일을 업로드 하기전에 저장할 폴더가 없으면 새로운 디렉토리를 생성
		File saveDir = new File(upLoadFolder);
		if(!saveDir.exists()) {
			saveDir.mkdirs();
		}
		// 업로드할 폴더와 저장할 이름을 담아 변수에 담는다.
		File saveFile = new File(upLoadFolder,saveName);
		
		try {
			file.transferTo(saveFile);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return saveName;
	}

	@Override
	public boolean file_delete(int fno) {
		// TODO Auto-generated method stub
		// 1.파일정보 추출
		FileDto fileVO = fDao.read(fno);
		// 2.파일의 물리적 경로 생성 
		File delFile = new File(upLoadFolder, fileVO.getFile_name());
		// 3. 파일이 있는지 확인한 후 
		if(delFile.exists()) {
			// 4.파일 삭제
			delFile.delete();
			// 5.DB정보 삭제
			fDao.delete(fno);
			return true;
		}
		return false;
	}

	
	@Transactional
	public void insert(BoardDto bDto) {
		// TODO Auto-generated method stub
		List<String> board_files = bDto.getBoard_files();
		
		if(board_files == null) return;
		
		for(String file_name : board_files) {
			// UUID를 제거하고 origin이름을 추출
			int bno = bDto.getBno();
			String file_origin_name = file_name.substring(37);
			FileDto fDto = FileDto.builder()
							.file_name(file_name)
							.origin_name(file_origin_name)
							.bno(bno).build();
			fDao.insert(fDto);
			
		}
	}
	
	@Override
	public void files_delete(int bno) {
		// TODO Auto-generated method stub
		List<FileDto> fileList = fDao.readByBno(bno);
		for(FileDto fileVO : fileList) {
			//1.File객체생성
			File delFile = new File(upLoadFolder, fileVO.getFile_name());
			//2.실제파일을 삭제
			if(delFile.exists()) delFile.delete();
		}
		fDao.deletes(bno);
	}

	@Override
	public List<FileDto> readByBno(int bno) {
		// TODO Auto-generated method stub
		return fDao.readByBno(bno);
	}
}
