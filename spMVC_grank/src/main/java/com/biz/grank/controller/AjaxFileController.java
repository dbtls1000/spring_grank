package com.biz.grank.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.biz.grank.service.AjaxFileService;
import com.biz.grank.util.MediaUtils;
import com.biz.grank.util.UploadFileUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("upload/*")
public class AjaxFileController {
	
	@Resource(name = "uploadPath")
    String uploadPath;
	
	@Autowired
	AjaxFileService afService;
//  이전 방식
//	// 이미지 파일을 드래그앤드롭한 경우 업로드폴더에 업로드 실행단
//	@ResponseBody
//	@PostMapping("fileup")
//	public List<FileDto> file_up(MultipartHttpServletRequest files) {
//		List<FileDto> fileDtoList = afService.upLoads(files);
//		return fileDtoList;
//	}
//	
//	// 이미지를 삭제하는 경우
//	@ResponseBody
//	@GetMapping("delete")
//	public String delete(@RequestParam(defaultValue = "0")int fno,String file_name) {
//		log.info(">>fno>>"+fno);
//		boolean okDelete = afService.file_delete(fno,file_name);
//		
//		// okDelete가 true면 OK를 리턴
//		if(okDelete) return "OK";
//		// false일 경우 FAIL을 리턴
//		else return "FAIL";
//	}
	
	
	// uploadAjax에서 받은 데이터를 post방식으로 명시하여 실행
    // 업로드한 파일은 MultipartFile 변수에 저장됨
    @ResponseBody // json 형식으로 리턴
    @RequestMapping(value = "uploadAjax", 
    method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
        // 업로드한 파일 정보와 Http 상태 코드를 함께 리턴
        return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
    }
    
    // 이미지 표시 기능
    @ResponseBody // view가 아닌 data 리턴
    @RequestMapping("displayFile")
    public ResponseEntity<byte[]> displayFile(String fileName) 
            throws Exception {
        // 서버의 파일을 다운로드하기 위한 스트림
        InputStream in = null; // java.io
        ResponseEntity<byte[]> entity = null;
        try {
            // 확장자 검사
            String formatName = fileName.substring(
                    fileName.lastIndexOf(".") + 1);
            // jpg,gif,png파일이 아닌 경우 null
            MediaType mType = MediaUtils.getMediaType(formatName);
            // 헤더 구성 객체
            HttpHeaders headers = new HttpHeaders();
            // InputStream 생성
            in = new FileInputStream(uploadPath + fileName);
//            if (mType != null) { // 이미지 파일이면
//                headers.setContentType(mType);
//            } else { // 이미지가 아니면
                fileName = fileName.substring(
                        fileName.indexOf("_") + 1);
                // 다운로드용 컨텐트 타입
                headers.setContentType(
                        MediaType.APPLICATION_OCTET_STREAM);
                // 큰 따옴표 내부에 " \" "
                // 바이트배열을 스트링으로
                // iso-8859-1 서유럽언어
                // new String(fileName.getBytes("utf-8"),"iso-8859-1")
                headers.add("Content-Disposition","attachment; filename=\"" + new String(fileName.getBytes("utf-8"), "iso-8859-1") + "\"");
                // headers.add("Content-Disposition"
                // ,"attachment; filename='"+fileName+"'");
//            }
            // 바이트배열, 헤더
            entity = new ResponseEntity<byte[]>(
                    IOUtils.toByteArray(in), headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<byte[]>(
                    HttpStatus.BAD_REQUEST);
        } finally {
            if (in != null)
                in.close(); // 스트림 닫기
        }
        return entity;
    }
    
    @ResponseBody //뷰가 아닌 데이터를 리턴
    @RequestMapping(value="deleteFile"
        ,method=RequestMethod.POST)
    //메시지와 에러코드를 같이 돌려줌 (??)
    public ResponseEntity<String> deleteFile(String fileName,@RequestParam(defaultValue = "0")int fno){
        log.info("fileName:"+fileName);
        //확장자 검사
        String formatName=fileName.substring(
                fileName.lastIndexOf(".")+1);
        // jpg,gif,png파일이 아닌 경우 null
        MediaType mType=MediaUtils.getMediaType(formatName);
        
        // 로컬에 업로드된 파일 삭제
        if(mType != null) { //이미지 파일이면 원본이미지 삭제
            String front=fileName.substring(0, 12);
            String end=fileName.substring(14);
//         File.separatorChar : 유닉스 / 윈도우즈\    
            new File(uploadPath+(front+end).replace(
                    '/',File.separatorChar)).delete();
        }
        // 로컬에 업로드된 원본 파일 삭제(이미지이면 썸네일 삭제)
        new File(uploadPath+fileName.replace(
                '/',File.separatorChar)).delete();
        //레코드 삭제(fno가 0이 아니면 DB도 삭제해줘야 함)
        if(fno != 0) {
        	afService.deleteFile(fno);
        }
        
        return new ResponseEntity<String>("deleted"
                ,HttpStatus.OK);
    }
}
