
package com.finalProject.util;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice(basePackages = "com.finalProject.controller.admin")
public class GlobalExceptionHandler {

	@ExceptionHandler(Exception.class)
	public ModelAndView handleException(Exception ex, Model model) {
		ModelAndView mav = new ModelAndView();

		mav.addObject("errorMessage", ex.getMessage());
		mav.addObject("buttonMesage" , "돌아가기");
		mav.setViewName("admin/error");
		return mav;
	}
}
