package com.finalProject.persistence;

import com.finalProject.model.OrderLevelDTO;
import com.finalProject.model.OrderMemberDTO;
import com.finalProject.model.OrderProductDTO;

public interface OrderDAO {

	OrderProductDTO selectOrderProduct(int productNo);

	String selectOrderProductImg(int productNo);

	OrderMemberDTO selectOrderMember(String memberId);

	OrderLevelDTO selectMemberLever(int memberLevel);

}
