package com.finalProject.model.review;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class ProductDetailReviewDTO {

	private int review_no;
	private int product_no;
	private String member_id;
	private String review_title;
	private String review_content;
	private Timestamp register_date;
	private int review_score;
	private String nickname;
	private Integer review_ref;
	
    // 쉼표로 구분된 이미지 URL 문자열
    private String reviewImgs;

    // 쉼표로 구분된 문자열을 리스트로 변환
    public List<String> getReviewImgList() {
        if (reviewImgs != null && !reviewImgs.isEmpty()) {
            return Arrays.asList(reviewImgs.split(","));
        }
        return new ArrayList<>();
    }
	
}
