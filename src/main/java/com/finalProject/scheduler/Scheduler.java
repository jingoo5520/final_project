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

	@Scheduled(cron = "* * * * * *") // 매초마다
	public void performTask() {
		System.out.println("작업 실행 중...");
		// 여기에 실제 작업 로직을 추가하세요
	}

	// cron 표현식을 사용할 수도 있습니다.
	@Scheduled(cron = "0 31 20 * * ?") // 매일 20시 16분 마다 실행
	public void performCronTask() {
		System.out.println("크론 작업 실행 중...");
		try {
			int count = memberService.getMemberCount(); // 회원 수 저장
			System.out.println("회원 수 : " + count);
			// 회원 수 만큼 반복
			for (int i = 0; i < count; i++) {
				String member_id = memberService.getMemberId(i); // 회원 아이디 받기
				int totalPrice = memberService.getTotalPriceByMemberId(member_id); // 회원의 3달간 결제금액 조회
				int result = memberService.updateMemberLevel(member_id, totalPrice); // 회원 등급 업데이트
				System.out.println("회원 아이디 : " + member_id + ", 사용금액 : " + totalPrice + ", update결과 : " + result);

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
