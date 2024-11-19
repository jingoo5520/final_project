package com.finalProject.service.member;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.BlackInfoDTO;
import com.finalProject.model.DeliveryDTO;
import com.finalProject.model.DeliveryVO;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;
import com.finalProject.model.MemberPointDTO;
import com.finalProject.model.UsedCouponDTO;
import com.finalProject.model.PaidCouponDTO;
import com.finalProject.model.PointDTO;
import com.finalProject.model.RecentCouponDTO;
import com.finalProject.persistence.MemberDAO;
import com.finalProject.persistence.PointDAO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO memberDAO;

	@Inject
	private PointDAO pDAO;

	// 로그인
	@Override
	public LoginDTO login(LoginDTO loginDTO) throws Exception {
		LoginDTO data = memberDAO.login(loginDTO);
		return data;
	}

	// id, email, phone_number 중복 체크
	@Override
	public boolean autoDuplicate(Map<String, Object> map) throws Exception {
		return memberDAO.autoDuplicate(map);
	}

	// 회원가입
	@Override
	public int signUp(MemberDTO signUpDTO) throws Exception {
		return memberDAO.signUp(signUpDTO);
	}

	// 자동 로그인 정보 저장
	@Override
	public void setAutoLogin(String member_id, String code, int AUTOLOGIN_DATE) throws Exception {
		memberDAO.setAutoLogin(member_id, code, AUTOLOGIN_DATE);
	}

	// 자동 로그인 정보 조회
	@Override
	public LoginDTO getAutoLogin(String autologin_code) throws Exception {
		return memberDAO.getAutoLogin(autologin_code);
	}

	// 마이 페이지 비밀번호 인증
	@Override
	public boolean auth(String member_id, String member_pwd) throws Exception {
		return memberDAO.auth(member_id, member_pwd);
	}

	// 마이 페이지 회원 정보 조회
	@Override
	public MemberDTO getMember(String member_id) throws Exception {
		return memberDAO.getMember(member_id);
	}

	// 마이 페이지 회원 정보 수정
	@Transactional
	@Override
	public boolean updateMember(MemberDTO memberDTO, String member_id, HttpServletRequest request) throws Exception {
		boolean result = false;
		HttpSession ses = request.getSession();
		if (memberDAO.updateMember(memberDTO)) {
			LoginDTO loginDTO = memberDAO.updateLoginSession(member_id);
			if (loginDTO != null) {
				ses.setAttribute("loginMember", loginDTO);
				result = true;
			}
		}
		return result;
	}

	// 마이 페이지 비밀번호 변경
	@Override
	public boolean updateMemberPwd(Map<String, String> map) throws Exception {
		return memberDAO.updateMemberPwd(map);
	}

	// 마이 페이지 회원탈퇴
	@Override
	public boolean withDrawMember(String member_id) throws Exception {
		return memberDAO.withDrawMember(member_id);
	}

	// 아이디 찾기
	@Override
	public LoginDTO findIdbyEmail(String email) throws Exception {
		return memberDAO.findIdbyEmail(email);
	}

	// 비밀번호 찾기
	@Transactional
	@Override
	public boolean findPwd(String email, String member_id, String member_pwd) throws Exception {
		boolean result = false;
		if (memberDAO.findPwd(email, member_id)) {
			if (memberDAO.updateRandomPwd(member_pwd, member_id)) {
				result = true;
			}
		}
		return result;
	}

	// 회원의 찜목록 조회
	@Override
	public int[] getWishList(String member_id) throws Exception {
		return memberDAO.getWishList(member_id);
	}

	// 찜 토글 동작(찜하기, 찜해제)
	@Transactional
	@Override
	public int saveWish(int product_no, String member_id) throws Exception {
		int result = -1;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("product_no", product_no);
		if (memberDAO.checkWishStatus(map) == 0) { // 찜 상태를 확인 (0이면 insert 1이면 delete)
			memberDAO.insertWish(map); // 찜 정보 추가
			result = 0;
		} else {
			memberDAO.deleteWish(map); // 찜 정보 삭제
			result = 1;
		}
		return result;
	}

	// 기본주소로 저장(회원가입)
	@Override
	public void saveAdddress(MemberDTO memberDTO, String addressName) throws Exception {
		memberDAO.saveAddress(memberDTO, addressName);
	}

	// 이메일로 회원 조회(카카오 로그인)
	@Override
	public LoginDTO selectMemberByEmail(MemberDTO userInfo) throws Exception {
		return memberDAO.selectMemberByEmail(userInfo);
	}

	// 주문페이지에서 입력한 주소로 회원 주소지 변경
	@Override
	public boolean updateAddress(DeliveryVO deliveryVO) throws Exception {
		return memberDAO.updateAddress(deliveryVO);
	}

	// 주문페이지에서 입력한 주소 배송지로 저장
	@Override
	@Transactional(rollbackFor = { Exception.class })
	public void saveDelivery(DeliveryVO deliveryVO) throws Exception {

		if (deliveryVO.getIsMain().equals("M")) {
			// 기본 배송지로 저장할 때
			// 기본배송지 데이터 조회
			Integer mainDeliveryNo = memberDAO.selectMainDeliveryNo(deliveryVO.getMemberId());

			if (mainDeliveryNo != null) {
				// 기존의 기본배송지를 일반배송지로 변경
				memberDAO.updateDeliveryMainToSub(mainDeliveryNo);
			}
		}

		// 배송지 저장
		memberDAO.insertDelivery(deliveryVO);

	}

	// 배송지 목록 조회
	@Override
	public List<DeliveryDTO> getDeliveryList(String memberId) throws Exception {
		return memberDAO.selectDeliveryList(memberId);
	}

	// 쿠폰 목록 조회
	@Override
	public List<PaidCouponDTO> getCouponList(String memberId, String currentTime) throws Exception {
		Map<String, String> param = new HashMap<String, String>();
		param.put("memberId", memberId);
		param.put("currentTime", currentTime);

		List<PaidCouponDTO> couponList = memberDAO.selectCouponList(param);

		for (PaidCouponDTO coupon : couponList) {
			coupon.setPay_date(coupon.getPay_date().substring(0, 10));
			coupon.setExpire_date(coupon.getExpire_date().substring(0, 10));
		}
		return couponList;
	}

	// naver_id로 회원 조회(네이버 로그인)
	@Override
	public LoginDTO selectMemberByNaverId(String naver_id) throws Exception {

		return memberDAO.selectMemberByNaverId(naver_id);
	}

	@Override
	public int signUpNaver(MemberDTO memberDTO) throws Exception {
		return memberDAO.signUpNaver(memberDTO);
	}

	// 배송지 수정
	@Override
	@Transactional(rollbackFor = { Exception.class })
	public void modifyDelivery(DeliveryDTO deliveryDTO) throws Exception {
		if (deliveryDTO.getIs_main().equals("M")) {
			// 기본 배송지로 저장할 때
			// 기본배송지 데이터 조회
			Integer mainDeliveryNo = memberDAO.selectMainDeliveryNo(deliveryDTO.getMember_id());

			if (mainDeliveryNo != null) {
				// 기존의 기본배송지를 일반배송지로 변경
				memberDAO.updateDeliveryMainToSub(mainDeliveryNo);
			}
		}

		// 배송지 저장
		memberDAO.updateDelivery(deliveryDTO);

	}

	// 배송지 삭제
	@Override
	public void deleteDelivery(int deliveryNo) throws Exception {
		memberDAO.deleteDelivery(deliveryNo);
	}

	// 최근 3개월 쿠폰 조회
	@Override
	public List<RecentCouponDTO> getRecentCouponList(String memberId) throws Exception {

		List<RecentCouponDTO> couponList = memberDAO.selectRecentCouponList(memberId);

		for (RecentCouponDTO coupon : couponList) {
			coupon.setPay_date(coupon.getPay_date().substring(0, 10));
			coupon.setExpire_date(coupon.getExpire_date().substring(0, 10));
		}
		return couponList;
	}

	// 회원의 현재 보유한 포인트와 총 사용한 포인트 조회
	@Override
	public MemberPointDTO getMemberPoint(String memberId) throws Exception {
		return memberDAO.getMemberPoint(memberId);
	}

	// 회원의 포인트 내역의 총 페이지 개수 반환
	@Override
	public int getPointPagingInfo(String pointType, String memberId) throws Exception {
		int pointListCnt = memberDAO.getTotalPointList(pointType, memberId);

		if (pointListCnt % 10 == 0) {
			return pointListCnt / 10;
		} else {
			return (pointListCnt / 10) + 1;
		}
	}

	// 회원의 포인트 적립내역 조회
	@Override
	public List<PointDTO> getEarnedPointList(String memberId, int pageNo) throws Exception {
		return memberDAO.selectEarnedPointList(memberId, pageNo);
	}

	// 회원의 포인트 사용내역 조회
	@Override
	public List<PointDTO> getUsedPointList(String memberId, int pageNo) throws Exception {
		return memberDAO.selectUsedPointList(memberId, pageNo);
	}

	// 회원 수 받기(스케쥴러)
	@Override
	public int getMemberCount() throws Exception {
		return memberDAO.getMemberCount();
	}

	// 회원 아이디 받기(스케쥴러)
	@Override
	public String getMemberId(int i) throws Exception {
		return memberDAO.getMemberId(i);
	}

	// 회원의 3달간 결제금액 받기(스케쥴러)
	@Override
	public int getTotalPriceByMemberId(String member_id) throws Exception {
		return memberDAO.getTotalPriceByMemberId(member_id);
	}

	// 회원 등급 업데이트(스케쥴러)
	@Override
	public int updateMemberLevel(String member_id, int totalPrice) throws Exception {
		return memberDAO.updateMemberLevel(member_id, totalPrice);
	}

	// 회원 더미 데이터 insert
	@Override
	public void tumpMemberData(MemberDTO mDTO) throws Exception {
		memberDAO.tumpMemberData(mDTO);
		pDAO.insertPointPlus(mDTO.getMember_id(), 2);
	}

	// 회원의 블랙정보 받기(로그인)
	@Override
	public BlackInfoDTO memberBlackInfo(String member_id) throws Exception {
		return memberDAO.getMemberBlackInfo(member_id);
	}

}
