package com.finalProject.service.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.finalProject.model.BlackInfoDTO;
import com.finalProject.model.DeliveryDTO;
import com.finalProject.model.DeliveryVO;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;
import com.finalProject.model.MemberPointDTO;
import com.finalProject.model.PaidCouponDTO;
import com.finalProject.model.PointDTO;
import com.finalProject.model.RecentCouponDTO;
import com.finalProject.model.admin.black.BlackInsertDTO;

public interface MemberService {

	// 로그인
	LoginDTO login(LoginDTO loginDTO) throws Exception;

	// id, email, phone_number 중복 체크
	boolean autoDuplicate(Map<String, Object> map) throws Exception;

	// 회원가입
	int signUp(MemberDTO signUpDTO) throws Exception;

	// 자동 로그인 정보 저장
	void setAutoLogin(String member_id, String code, int AUTOLOGIN_DATE) throws Exception;

	// 자동 로그인 정보 조회
	LoginDTO getAutoLogin(String autologin_code) throws Exception;

	// 마이 페이지 비밀번호 인증
	boolean auth(String member_id, String member_pwd) throws Exception;

	// 마이 페이지 회원 정보 조회
	MemberDTO getMember(String member_id)throws Exception;

	// 마이 페이지 회원 정보 수정
	boolean updateMember(MemberDTO memberDTO, String member_id, HttpServletRequest request)throws Exception;

	// 마이 페이지 비밀번호 변경
	boolean updateMemberPwd(Map<String, String> map)throws Exception;

	// 마이 페이지 회원탈퇴
	boolean withDrawMember(String member_id)throws Exception;

	// 아이디 찾기
	LoginDTO findIdbyEmail(String email)throws Exception;

	// 비밀번호 찾기
	boolean findPwd(String email, String member_id, String member_pwd)throws Exception;
	
	// 회원의 찜목록 조회
	int[] getWishList(String member_id)throws Exception;

	// 찜 토글 동작(찜하기, 찜해제)
	int saveWish(int product_no, String member_id)throws Exception;

	// 기본주소로 저장(회원가입)
	void saveAdddress(MemberDTO memberDTO, String addressName)throws Exception;

	// 이메일로 회원 조회(카카오 로그인)
	LoginDTO selectMemberByEmail(MemberDTO userInfo)throws Exception;
	
	// 주문페이지에서 입력한 주소로 회원 주소지 변경
	boolean updateAddress(DeliveryVO deliveryVO) throws Exception;
	
	// 주문페이지에서 입력한 주소 배송지로 저장
	void saveDelivery(DeliveryVO deliveryVO) throws Exception;
	
	// 배송지 목록 조회
	List<DeliveryDTO> getDeliveryList(String memberId) throws Exception;
	
	// 쿠폰 목록 조회
	List<PaidCouponDTO> getCouponList(String memberId, String currentTime) throws Exception;

	// naver_id로 회원 조회(네이버 로그인)
	LoginDTO selectMemberByNaverId(String naver_id)throws Exception;

	// 네이버 간편가입
	int signUpNaver(MemberDTO memberDTO)throws Exception;
	
	// 배송지 수정
	void modifyDelivery(DeliveryDTO deliveryDTO) throws Exception;
	
	// 배송지 삭제
	void deleteDelivery(int deliveryNo) throws Exception;

	// 회원 수 받기(스케쥴러)
	int getMemberCount()throws Exception;

	// 회원 아이디 받기(스케쥴러)
	String getMemberId(int i)throws Exception;

	// 회원의 3달간 결제금액 받기(스케쥴러)
	int getTotalPriceByMemberId(String member_id)throws Exception;

	// 회원 등급 업데이트(스케쥴러)
	int updateMemberLevel(String member_id, int totalPrice)throws Exception;

	// 회원 더미 데이터 insert
	void tumpMemberData(MemberDTO mDTO)throws Exception;
	
	// 최근 3개월 쿠폰 조회
	List<RecentCouponDTO> getRecentCouponList(String memberId) throws Exception;
	
	// 회원의 현재 보유한 포인트와 총 사용한 포인트 조회
	MemberPointDTO getMemberPoint(String member_id) throws Exception;
	
	// 회원의 포인트 내역의 총 페이지 개수 반환
	int getPointPagingInfo(String pointType, String memberId) throws Exception;

	// 회원의 포인트 적립내역 조회
	List<PointDTO> getEarnedPointList(String memberId, int pageNo) throws Exception;
	
	// 회원의 포인트 사용내역 조회
	List<PointDTO> getUsedPointList(String memberId, int pageNo) throws Exception;

	// 회원의 블랙정보 받기(로그인)
	BlackInfoDTO memberBlackInfo(String member_id)throws Exception;


	
}
