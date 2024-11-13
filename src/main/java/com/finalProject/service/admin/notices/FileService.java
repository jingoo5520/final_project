package com.finalProject.service.admin.notices;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService {

	private final HttpServletRequest request;
	
    public FileService(HttpServletRequest request) {
        this.request = request;
    }

    // 파일 업로드 메서드
    public String uploadFile(MultipartFile file, String filePrefix) throws IOException {
        String BASE_UPLOAD_DIR = request.getSession().getServletContext().getRealPath("/resources/eventImages/");

        // 경로가 없다면 디렉토리 생성
        File uploadDir = new File(BASE_UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // 파일 이름에 접두사 추가하여 새 파일 이름 생성
    	String fileName = filePrefix + "_" + file.getOriginalFilename(); // 파일 이름에 접두사 추가
        
    	// 파일 경로 
    	Path uploadPath = Paths.get(BASE_UPLOAD_DIR + fileName);
    	
    	// 파일을 해당 경로에 저장
        Files.copy(file.getInputStream(), uploadPath);
        
        // 업로드된 파일 이름 반환
        return fileName;
    }

    // 파일 삭제 메서드
    public boolean deleteFile(String fileName) {

        String BASE_UPLOAD_DIR = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
    	
    	File file = new File(BASE_UPLOAD_DIR + fileName);
    	
        // 파일이 존재하면 삭제
        if (file.exists()) {
            return file.delete();
        }
    	
        return file.delete();
    }
    
    public String uploadFile(String filePath, String filePrefix) throws IOException {
        
    	//파일 경로 설정
    	Path uploadPath = Paths.get(filePath + filePrefix);
    	
    	// 파일을 지정된 경로에 저장
        Files.copy(new File(filePath).toPath(), uploadPath); 
        return filePrefix; // 업로드된 파일 이름 반환
    }
    
}
