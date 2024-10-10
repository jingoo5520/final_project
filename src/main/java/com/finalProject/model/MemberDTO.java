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
		
		private final int value; // ���� �� ����

        Admin(int value) { // �⺻ ������
            this.value = value; // ���޵� value�� �ν��Ͻ� ������ ����
        }

        public int getValue() { // ���� �� ��ȯ
            return value; // ���� enum �ν��Ͻ��� value ��ȯ
        }

        public static Admin fromValue(int value) { // ���� �����κ��� enum �ν��Ͻ��� �������� �޼���
            for (Admin admin : Admin.values()) { // ��� enum ����� �ݺ�
                if (admin.getValue() == value) { // ���ڷ� ���޵� value�� ���� admin�� value�� ��ġ�ϸ�

                    return admin; // �ش� enum �ν��Ͻ��� ��ȯ
                }
            }
            throw new IllegalArgumentException("Invalid value for Admin: " + value); // ��ȿ���� ���� ���� ���� ���� �߻�
        }
    }
}
