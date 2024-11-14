package com.finalProject.util.scheduler;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.Scheduled;

import com.finalProject.service.order.OrderService;

public class ScheduledTasks {
	@Inject
	private OrderService orderService;
	
	@Scheduled(cron = "0 0 0 * * ?")
    public void runAtEverydayMidnight() {
		System.out.println("매일 자정 스케줄된 작업을 실행합니다");
        orderService.updateOrderStatusAuto();
        System.out.println("1주일이 지난 결제 완료 상품을 배송 완료로 변경함");
    }
	
	// 테스트용
//    @Scheduled(cron = "*/10 * * * * *")
//    public void runAtEvery10seconds() {
//        System.out.println("매 10초마다 실행됩니다.");
//    }
}
