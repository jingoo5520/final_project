package com.finalProject.service;

import org.springframework.stereotype.Service;

import com.finalProject.model.OrderMemberDTO;
import com.finalProject.model.OrderMemberVO;
import com.finalProject.model.OrderProductVO;

@Service
public interface OrderService {

	OrderProductVO viewProduct(int productNo);

	OrderMemberVO viewMember(String memberId);

}
