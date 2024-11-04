package com.finalProject.service.admin.notices;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class FileService {

    private final String UPLOAD_DIR = "C:/spring/temp/";

    // 파일 업로드 메서드
    public String uploadFile(MultipartFile file, String filePrefix) throws IOException {
        String fileName = filePrefix + "_" + file.getOriginalFilename(); // 파일 이름에 접두사 추가
        Path uploadPath = Paths.get(UPLOAD_DIR + fileName);
        Files.copy(file.getInputStream(), uploadPath);
        return fileName;
    }

    // 파일 삭제 메서드
    public boolean deleteFile(String fileName) {
        File file = new File(UPLOAD_DIR + fileName);
        return file.delete();
    }
}
