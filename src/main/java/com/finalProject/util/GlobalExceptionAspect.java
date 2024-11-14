package com.finalProject.util;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionAspect {

	@ExceptionHandler(Exception.class)
    public String handleException(Exception e) {
		System.out.println("Exception 발생");
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("/admin/coupon/coupons");  // 리다이렉트할 URL 설정
        return "/user/pages/warning";
        
    }
}
