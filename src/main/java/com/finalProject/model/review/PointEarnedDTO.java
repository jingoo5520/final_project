package com.finalProject.model.review;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PointEarnedDTO {
	
    private String member_id;
    private int point_code;
    private int earned_point;
}
