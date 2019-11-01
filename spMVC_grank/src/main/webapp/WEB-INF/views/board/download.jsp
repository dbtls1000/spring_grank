<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="org.springframework.ui.Model" %>
<%@ page import="java.net.URLEncoder" %>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<% 
try{
	String header = request.getHeader("User-Agent");
	System.out.println(header);
	// ISO-8859-1 인코딩은 대부분의 브라우저에 설정된 기본 문자셋
	String path = new String(request.getAttribute("path").toString().getBytes("utf-8"), "ISO-8859-1");
	String originName = new String(request.getAttribute("originName").toString().getBytes("utf-8"), "ISO-8859-1");
	String fileName =  new String(request.getAttribute("fileName").toString().getBytes("utf-8"), "ISO-8859-1");
	
	if(header.contains("MSIE") || header.contains("Trident")){ // 익스플로러의 경우 한글 처리
		fileName = URLEncoder.encode(request.getAttribute("fileName").toString(),"UTF-8").replaceAll("\\+","%20");
	} else{ // 익스플로러 이외 한글처리
		fileName = new String(request.getAttribute("fileName").toString().getBytes("utf-8"), "ISO-8859-1");
	}
	
	File file = new File(path + "/" +fileName);
			
	response.reset(); // 모두 초기화
	
	response.setContentType("application/octer-stream");
	
	// 헤더에 내가 원하는 전송할 파일 이름을 설정
	response.setHeader("Content-Disposition","attachment;filename="+fileName+"");
	
	// 인코딩 설정 변경
	response.setHeader("Content-Transper-Encoding","binary");
	
	// 파일 사이즈 설정
	response.setContentLength((int) file.length());
	
	response.setHeader("Pragma","no-chche");
	
	response.setHeader("Expires","-1");
	
	byte[] data = new byte[2048];
	
	FileInputStream fis = new FileInputStream(file);
	
	BufferedInputStream bis = new BufferedInputStream(fis);
	
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
	
	int count = 0;
	while((count = bis.read(data)) != -1){
		bos.write(data,0,count);
	}
	
	if(fis != null)	fis.close();
	if(bis != null)	bis.close();
	if(bos != null)	bos.close();
	
	// file.delete(); 사용자 다운 시 파일을 삭제하려면 추가
	
} catch (Exception e){
	System.out.println("download error : " + e);
} 

out.clear();
out = pageContext.pushBody();
%>