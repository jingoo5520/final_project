package com.finalProject.model.admin.black;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class BlackInsertDTO {
	private List<String> memberIdList;
	private String loginMember;
	private String blackReason;

}
