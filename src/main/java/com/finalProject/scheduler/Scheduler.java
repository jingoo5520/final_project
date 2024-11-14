package com.finalProject.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.finalProject.service.member.MemberService;

@Component
@EnableScheduling
public class Scheduler {

	@Autowired
	private MemberService memberService;

//	@Scheduled(cron = "30 * * * * *") // 30초마다
//	public void performTask() {
//		try {
//			int count = memberService.getMemberCount(); // 회원 수 저장
//			System.out.println("회원 수 : " + count);
//			// 회원 수 만큼 반복
//			for (int i = 0; i < count; i++) {
//				String member_id = memberService.getMemberId(i); // 회원 아이디 받기
//				int totalPrice = memberService.getTotalPriceByMemberId(member_id); // 회원의 지난 1년간 결제금액 조회
//				int result = memberService.updateMemberLevel(member_id, totalPrice); // 회원 등급 업데이트
//				System.out.println("회원 아이디 : " + member_id + ", 사용금액 : " + totalPrice + ", update결과 : " + result);
//			}
//			System.out.println("갱신 완료");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}

	@Scheduled(cron = "0 0 0 1 1/3 ?") // (0초, 0분, 0시, 1일, 1월/3개월마다, 요일상관없음)
	public void updateMembersLevel() {
		try {
			int count = memberService.getMemberCount(); // 회원 수 저장
			System.out.println("회원 수 : " + count);
			// 회원 수 만큼 반복
			for (int i = 0; i < count; i++) {
				String member_id = memberService.getMemberId(i); // 회원 아이디 받기
				int totalPrice = memberService.getTotalPriceByMemberId(member_id); // 회원의 지난 1년간 결제금액 조회
				int result = memberService.updateMemberLevel(member_id, totalPrice); // 회원 등급 업데이트
				System.out.println("회원 아이디 : " + member_id + ", 사용금액 : " + totalPrice + ", update결과 : " + result);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Scheduled(cron = "0 0/30 * 1/1 * ?") // (매일 30분마다 동작)
	public void test() {
		try {
			int count = memberService.getMemberCount(); // 회원 수 저장
			System.out.println("회원 수 : " + count);
			// 회원 수 만큼 반복
			for (int i = 0; i < count; i++) {
				String member_id = memberService.getMemberId(i); // 회원 아이디 받기
				int totalPrice = memberService.getTotalPriceByMemberId(member_id); // 회원의 지난 1년간 결제금액 조회
				int result = memberService.updateMemberLevel(member_id, totalPrice); // 회원 등급 업데이트
				System.out.println("회원 아이디 : " + member_id + ", 사용금액 : " + totalPrice + ", update결과 : " + result);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
