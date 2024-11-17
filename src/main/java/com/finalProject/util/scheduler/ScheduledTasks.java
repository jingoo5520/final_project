package com.finalProject.util.scheduler;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.Scheduled;

import com.finalProject.service.member.MemberService;
import com.finalProject.service.order.OrderService;

public class ScheduledTasks {
	@Inject
	private OrderService orderService;
	
	@Inject
	private MemberService memberService;
	
	@Scheduled(cron = "0 0 0 * * ?")
    public void runAtEverydayMidnight() {
		System.out.println("매일 자정 스케줄된 작업을 실행합니다");
        orderService.updateOrderStatusAuto();
        System.out.println("1주일이 지난 결제 완료 상품을 배송 완료로 변경함");
    }

	// 1월, 4월, 7월, 10월 1일(3개월 주기)마다 회원등급을 갱신
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
			System.out.println("갱신 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	 * @Scheduled(cron = "0 0/30 * 1/1 * ?") // (매일 30분마다 동작) public void test() {
	 * updateMembersLevel(); }
	 */
	
//	@Scheduled(cron = "30 * * * * *") // 30초마다
//	public void performTask() {
//		updateMembersLevel();
//	}

}
