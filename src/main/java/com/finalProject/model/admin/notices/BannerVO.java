package com.finalProject.model.admin.notices;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class BannerVO {
    
    private String fileName;     // 배너 파일명
    private String filePath;     // 배너 파일 경로

}