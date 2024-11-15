package com.finalProject.model.level;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class LevelDTO {
	private int level_no;
	private String level_name;
	private int level_min;
	private int level_max;
	private float level_dc;
	private float level_point;
	
}
