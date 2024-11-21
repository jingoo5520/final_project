package com.finalProject.controller.admin.notices;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.admin.notices.NoticeTypeStatus;

@RestController
@RequestMapping("/post")
public class ImageUploadController {

    @Autowired
    private WebApplicationContext context;
    
//    private static final String BASE_UPLOAD_DIR = "C:/spring/temp/";

    // 공통 파일 업로드 로직
    @RequestMapping("/uploadImage")
    private String uploadFile(@RequestParam("file") MultipartFile file,
                              @RequestParam("noticeType") String noticeType,
                              HttpServletRequest request) throws IOException {

    	
    	
    	String BASE_UPLOAD_DIR = request.getSession().getServletContext().getRealPath(File.separator + "resources" + File.separator + "eventImages" + File.separator);
        // noticeType이 N이면 NoticeType.N, E이면 NoticeType.E로 처리
        NoticeTypeStatus.NoticeType typeEnum = "N".equals(noticeType) 
                                                  ? NoticeTypeStatus.NoticeType.N 
                                                  : NoticeTypeStatus.NoticeType.E;

        // noticeType에 따른 파일 저장 경로 설정
        String prefix = "N".equals(noticeType) ? "notice_" : "event_";

        // 로그 출력
        System.out.println("Notice Type: " + typeEnum);

        String contentType = file.getContentType(); // MIME 타입 확인
        System.out.println("File type: " + contentType);

        // 파일 이름 생성
        String originalFileName = file.getOriginalFilename();
        String fileName = originalFileName.substring(0, originalFileName.lastIndexOf('.')); 
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf('.')); 
        String uuidFileName = prefix + UUID.randomUUID().toString() + "_" + fileName + fileExtension; // prefix 추가

        // 저장할 디렉토리 생성
        File uploadDir = new File(BASE_UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // 디렉토리가 없을 경우 생성
        }

        // 서버 경로에 이미지 저장
        File uploadFile = new File(uploadDir, uuidFileName);
        try {
            file.transferTo(uploadFile);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("파일 저장에 실패했습니다.");
        }

        System.out.println("파일이 저장된 경로: " + uploadFile.getAbsolutePath());

        return uuidFileName; // 저장된 파일 이름 반환
    }

    // 이미지 업로드 처리
    @PostMapping("/upload")
    public ResponseEntity<String> imageUpload(@RequestParam("file") MultipartFile file,
                                              @RequestParam("noticeType") String noticeType,
                                              HttpServletRequest request) {
        if (file.isEmpty() || noticeType == null || noticeType.isEmpty()) {
            return ResponseEntity.badRequest().body("파일이나 noticeType이 누락되었습니다.");
        }
        try {
        	String realPath = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
        	// 업로드된 파일의 이름
            String fileName = uploadFile(file, noticeType, request); // noticeType 전달
            System.out.println("fileName" + fileName);
            
            // AJAX에서 업로드된 파일의 이름을 응답으로 반환
            return ResponseEntity.ok(fileName);
        } catch (IOException e) {
            e.printStackTrace(); // 오류 추적
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("이미지 업로드 실패: " + e.getMessage());
        }
    }

    // 이미지 파일 불러오기 처리
    @GetMapping("/resources/eventImages/{imageName:.+}")
    public ResponseEntity<Resource> getImage(@PathVariable String imageName, HttpServletRequest request) {
        try {
        	String realPath = request.getSession().getServletContext().getRealPath("/resources/eventImages/");
            File file = new File(realPath, imageName);

            if (!file.exists()) {
                System.out.println("파일이 존재하지 않습니다: " + file.getAbsolutePath());
                return ResponseEntity.notFound().build();
            }

            Resource resource = new UrlResource(file.toURI());
            String mimeType = Files.probeContentType(file.toPath());
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(mimeType != null ? mimeType : MediaType.APPLICATION_OCTET_STREAM_VALUE))
                    .body(resource);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 새로운 메서드 추가: notice_content와 함께 저장
    @PostMapping("/saveNotice")
    public ResponseEntity<?> saveNotice(@RequestParam("noticeContent") String noticeContent) {
        // DB에 notice_content 저장 로직 구현
        // 예: noticeService.saveNotice(noticeContent);
        return ResponseEntity.ok("공지사항이 저장되었습니다.");
    }
}