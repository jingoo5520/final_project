package com.finalProject.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MemberDAOImpl implements MemberDAO {

	@Inject
	SqlSession ses;

	private String ns = "com.finalProject.mappers.memberMapper.";

	// 로그인
	@Override
	public LoginDTO login(LoginDTO loginDTO) throws Exception {
		return ses.selectOne(ns + "login", loginDTO);
	}

	// id, email, phone_number 중복 체크
	@Override
	public boolean autoDuplicate(Map<String, Object> map) {
		boolean result = false;
		// 중복인 경우 true
		if ((int) ses.selectOne(ns + "autoDuplicate", map) >= 1) {
			result = true;
			System.out.println("중복");
		}
		return result;
	}

	// 회원가입
	@Override
	public int signUp(MemberDTO signUpDTO) throws Exception {
		return ses.insert(ns + "signUpMember", signUpDTO);
	}

	// 자동 로그인 정보 저장
	@Override
	public void setAutoLogin(String member_id, String code, int AUTOLOGIN_DATE) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("autologin_code", code); // 자동로그인 코드
		map.put("autologin_date", AUTOLOGIN_DATE); // 자동로그인 유효기간
		ses.update(ns + "updateAutoLoginData", map);
	}

	// 자동 로그인 정보 조회
	@Override
	public LoginDTO getAutoLogin(String autologin_code) throws Exception {
		return ses.selectOne(ns + "selectAutoLoginData", autologin_code);
	}

	// 마이 페이지 비밀번호 인증
	@Override
	public boolean auth(String member_id, String member_pwd) throws Exception {
		boolean result = false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("member_pwd", member_pwd);
		LoginDTO loginDTO = ses.selectOne(ns + "login", map);
		if (loginDTO != null) {
			result = true;
		}

		return result;
	}

	// 마이 페이지 회원 정보 조회
	@Override
	public MemberDTO getMember(String member_id) throws Exception {
		return ses.selectOne(ns + "selectMemberById", member_id);
	}

	// 마이 페이지 회원 정보수정
	@Override
	public boolean updateMember(MemberDTO memberDTO) throws Exception {
		boolean result = false;
		if (ses.update(ns + "updateMember", memberDTO) == 1) {
			result = true;
		}
		return result;
	}

	// 마이 페이지 비밀번호 변경
	@Override
	public boolean updateMemberPwd(Map<String, String> map) throws Exception {
		boolean result = false;
		if (ses.update(ns + "updateMemberPwd", map) == 1) {
			result = true;
		}
		return result;
	}

	// 마이 페이지 회원탈퇴
	@Override
	public boolean withDrawMember(String member_id) throws Exception {
		boolean result = false;
		if (ses.update(ns + "withDrawMember", member_id) == 1) {
			result = true;
		}
		return result;
	}

	// 아이디 찾기
	@Override
	public LoginDTO findIdbyEmail(String email) throws Exception {
		LoginDTO member_id = null;
		if (ses.selectOne(ns + "selectIdByEmail", email) != null) {
			member_id = ses.selectOne(ns + "selectIdByEmail", email);
		}
		return member_id;
	}

	// 비밀번호 찾기
	@Override
	public boolean findPwd(String email, String member_id) throws Exception {
		boolean result = false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("member_id", member_id);
		if (ses.selectOne(ns + "selectPwd", map) != null) {
			result = true;
		}
		return result;
	}

	// 비밀번호 찾기 (랜덤비밀번호 지정)
	@Override
	public boolean updateRandomPwd(String member_pwd, String member_id) throws Exception {
		boolean result = false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("member_pwd", member_pwd);
		if (ses.update(ns + "updateRandomPwd", map) == 1) {
			result = true;
		}

		return result;
	}

	// 회원의 찜목록 조회
	@Override
	public int[] getWishList(String member_id) throws Exception {
		List<Integer> list = ses.selectList(ns + "selectWishListByMemberId", member_id);

		int[] result = new int[list.size()]; // 배열 크기를 select문으로 찾은 찜의 갯수크기로 설정
		for (int i = 0; i < list.size(); i++) { // 찜 목록크기만큼 반복
			result[i] = list.get(i); // int 배열에 list저장하기
		}

		return result;
	}

	// 찜 상태 확인(찜이 되있는지 안되있는지)
	@Override
	public int checkWishStatus(Map<String, Object> map) throws Exception {
		return ses.selectOne(ns + "selectWish", map);
	}

	// 찜 정보 추가
	@Override
	public void insertWish(Map<String, Object> map) throws Exception {
		ses.insert(ns + "insertWish", map);
	}

	// 찜 정보 삭제
	@Override
	public void deleteWish(Map<String, Object> map) throws Exception {
		ses.delete(ns + "deleteWish", map);
	}

	// 기본주소로 저장(회원가입)
	@Override
	public void saveAddress(MemberDTO memberDTO, String addressName) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("addressName", addressName);
		map.put("member_id", memberDTO.getMember_id());
		map.put("address", memberDTO.getAddress());
		ses.insert(ns + "saveAddressBySignUp", map);
	}

	// 이메일로 회원 조회(카카오 로그인)
	@Override
	public LoginDTO selectMemberByEmail(MemberDTO userInfo) throws Exception {
		return ses.selectOne(ns + "selectMemberByEmail", userInfo);
	}

	// 주문페이지에서 입력한 주소로 회원 주소지 변경
	@Override
	public boolean updateAddress(DeliveryVO deliveryVO) throws Exception {
		boolean result = false;
		if (ses.update(ns + "updateAddress", deliveryVO) == 1) {
			result = true;
		}
		return result;
	}

	// 배송지 저장
	@Override
	public void insertDelivery(DeliveryVO deliveryVO) throws Exception {
		ses.insert(ns + "insertDelivery", deliveryVO);
	}

	// 기본배송지 데이터 조회
	@Override
	public Integer selectMainDeliveryNo(String member_id) throws Exception {
		return ses.selectOne(ns + "selectMainDelivery", member_id);
	}

	// 기존의 기본배송지를 일반배송지로 변경
	@Override
	public void updateDeliveryMainToSub(Integer delivery_no) throws Exception {
		ses.update(ns + "updateDeliveryMainToSub", delivery_no);
	}

	// 배송지 목록 조회
	@Override
	public List<DeliveryDTO> selectDeliveryList(String memberId) throws Exception {
		return ses.selectList(ns + "selectDeliveryList", memberId);
	}

	// 쿠폰 목록 조회
	@Override
	public List<PaidCouponDTO> selectCouponList(Map<String, String> param) throws Exception {
		return ses.selectList(ns + "selectCouponList", param);
	}

	// naver_id로 회원 조회(네이버 로그인)
	@Override
	public LoginDTO selectMemberByNaverId(String naver_id) throws Exception {
		return ses.selectOne(ns + "selectMemberByNaverId", naver_id);
	}

	// 네이버 간편가입
	@Override
	public int signUpNaver(MemberDTO memberDTO) throws Exception {
		return ses.insert(ns + "signUpMemberByNaver", memberDTO);
	}

	// 배송지 수정
	@Override
	public void updateDelivery(DeliveryDTO deliveryDTO) throws Exception {
		ses.update(ns + "updateDeliveryInfo", deliveryDTO);
	}

	// 배송지 삭제
	@Override
	public void deleteDelivery(int deliveryNo) throws Exception {
		ses.delete(ns + "deleteDeliveryInfo", deliveryNo);
	}
	
	// 사용한 쿠폰 조회
	@Override
	public List<UsedCouponDTO> selectUsedCouponList(String memberId) throws Exception {
		return ses.selectList(ns + "selectUsedCouponList", memberId);
	}

	// 최근 3개월 쿠폰 조회
	@Override
	public List<RecentCouponDTO> selectRecentCouponList(String memberId) throws Exception {
		return ses.selectList(ns + "selectRecentCouponList", memberId);
	}

	// 회원의 현재 보유한 포인트와 총 사용한 포인트 조회
	@Override
	public MemberPointDTO getMemberPoint(String memberId) throws Exception {
		return ses.selectOne(ns + "selectMemberPoint", memberId);
	}

	// 회원의 포인트 내역의 총 개수 조회
	@Override
	public int getTotalPointList(String pointType, String memberId) throws Exception {
		int totalPointListCnt = 0; 
		if (pointType.equals("earned")) {
			totalPointListCnt = ses.selectOne(ns + "selectCntOfEarnedPoint", memberId);
		} else if (pointType.equals("used")) {
			totalPointListCnt = ses.selectOne(ns + "selectCntOfUsedPoint", memberId);
		}
		
		return totalPointListCnt;
	}

	// 회원의 포인트 적립내역 조회
	@Override
	public List<PointDTO> selectEarnedPointList(String memberId, int pageNo) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("offset", (pageNo - 1) * 10);
		return ses.selectList(ns + "selectEarnedPointListByPageNo", param);
	}

	// 회원의 포인트 사용내역 조회
	@Override
	public List<PointDTO> selectUsedPointList(String memberId, int pageNo) throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put("memberId", memberId);
		param.put("offset", (pageNo - 1) * 10);
		return ses.selectList(ns + "selectUsedPointListByPageNo", param);
	}

	// 회원 수 받기(스케쥴러)
	@Override
	public int getMemberCount() throws Exception {
		return ses.selectOne(ns+"getMemberTotalCount");
	}

	// 회원 아이디 받기(스케쥴러)
	@Override
	public String getMemberId(int i) throws Exception {
		return ses.selectOne(ns+"getMemberId", i);
	}

	// 회원의 3달간 결제금액 받기(스케쥴러)
	@Override
	public int getTotalPriceByMemberId(String member_id) throws Exception {
		return ses.selectOne(ns+"getTotalPriceByMemberId", member_id);
	}

	// 회원 등급 업데이트(스케쥴러)
	@Override
	public int updateMemberLevel(String member_id, int totalPrice) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("totalPrice", totalPrice);
		return ses.update(ns+"updateMemberLevel", map);
	}

	// 회원 더미 데이터 insert
	@Override
	public void tumpMemberData(MemberDTO mDTO) throws Exception {
		ses.insert(ns+"tumpMemberData", mDTO);
	}

	// 회원의 블랙정보 받기(로그인)
	@Override
	public BlackInfoDTO getMemberBlackInfo(String member_id) throws Exception {
		return ses.selectOne(ns+"getMemberBlackInfo", member_id);
	}

	@Override
	public LoginDTO updateLoginSession(String member_id) {
		return ses.selectOne(ns+"updateLoginSession", member_id);
	}

}
