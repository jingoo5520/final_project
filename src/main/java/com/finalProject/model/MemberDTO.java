package com.finalProject.model;

import java.sql.Timestamp;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Setter
@AllArgsConstructor
@ToString
public class MemberDTO {
	private String member_id;
	private String member_name;
	private String member_pwd;
	private String phone_number;
	private int birthday;
	private Gender gender;
	private String email;
	private String address;
	private int member_point;
	private int member_level;
	private Timestamp reg_date;
	private String member_status;
	private String nickName;
	private String member_image;
	private Admin is_admin;
	
	public enum Gender {
		M, 
		F, 
		N
	}
	
	public enum Admin {
		USER(0),
		MANAGER(1), 
		ADMIN(9);
		
		private final int value; // 정수 값 저장

        Admin(int value) { // 기본 생성자
            this.value = value; // 전달된 value를 인스턴스 변수에 저장
        }

        public int getValue() { // 정수 값 반환
            return value; // 현재 enum 인스턴스의 value 반환
        }

        public static Admin fromValue(int value) { // 정수 값으로부터 enum 인스턴스를 가져오는 메서드
            for (Admin admin : Admin.values()) { // 모든 enum 상수를 반복
                if (admin.getValue() == value) { // 인자로 전달된 value와 현재 admin의 value가 일치하면

                    return admin; // 해당 enum 인스턴스를 반환
                }
            }
            throw new IllegalArgumentException("Invalid value for Admin: " + value); // 유효하지 않은 값에 대해 예외 발생
        }
    }
}
