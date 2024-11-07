package com.finalProject.service.admin.coupon;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.CouponPayDTO;
import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.persistence.admin.coupon.CouponDAO;

@Service
public class CouponServiceImpl implements CouponService {

	@Inject
	CouponDAO cDao;

	@Override
	public List<CouponDTO> getCouponList() throws Exception {
		return cDao.selectCouponList();
	}

	@Override
	public Map<String, Object> getCouponList(PagingInfoNewDTO pagingInfoDTO) throws Exception {

		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);

		// setter 호출
		pi.setTotalDataCnt(cDao.getTotalCouponCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<CouponDTO> list = cDao.selectCouponList(pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}

	@Override
	public int createCoupon(CouponDTO couponDTO) throws Exception {
		return cDao.insertCoupon(couponDTO);
	}

	@Override
	public int updateCoupon(CouponDTO couponDTO) throws Exception {
		return cDao.updateCoupon(couponDTO);
	}

	@Override
	public int deleteCoupon(int coupon_no) throws Exception {
		return cDao.deleteCoupon(coupon_no);
	}

	@Override
	@Transactional
	public int payCoupon(List<String> memberIdList, int couponNo) throws Exception {

		List<CouponPayDTO> list = new ArrayList<CouponPayDTO>();

		CouponDTO coupon = cDao.selectCoupon(couponNo);

		// 전체 지급 쿠폰일 때
		if (memberIdList.size() == 1 && memberIdList.get(0) == "All") {
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			String couponCode = uuid.substring(0, 16);

			Timestamp time = new Timestamp(System.currentTimeMillis());
			System.out.println(time);
			System.out.println(coupon.getCoupon_use_days());

			LocalDateTime dateTime = time.toLocalDateTime();
			LocalDateTime newDateTime = dateTime.plus(coupon.getCoupon_use_days(), ChronoUnit.DAYS);
			Timestamp newTimestamp = Timestamp.valueOf(newDateTime);

			list.add(new CouponPayDTO(couponNo, couponCode, "All", newTimestamp));
		}
		// 개인 지급 쿠폰일 때
		else {
			for (String memberId : memberIdList) {
				// "-" 빼면 32자리
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String couponCode = uuid.substring(0, 16);
				System.out.println(couponCode);

				Timestamp time = new Timestamp(System.currentTimeMillis());
				System.out.println(time);
				System.out.println(coupon.getCoupon_use_days());

				LocalDateTime dateTime = time.toLocalDateTime();
				LocalDateTime newDateTime = dateTime.plus(coupon.getCoupon_use_days(), ChronoUnit.DAYS);
				Timestamp newTimestamp = Timestamp.valueOf(newDateTime);

				list.add(new CouponPayDTO(couponNo, couponCode, memberId, newTimestamp));
			}
		}

		return cDao.insertCouponPayLogs(list);
	}

	@Override
	public Map<String, Object> getCouponPayLogList(PagingInfoNewDTO pagingInfoDTO) throws Exception {

		PagingInfoNew pi = new PagingInfoNew(pagingInfoDTO);
		
		// setter 호출
		pi.setTotalDataCnt(cDao.getCouponPayLogCnt());

		pi.setTotalPageCnt();
		pi.setStartRowIndex();

		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();

		Map<String, Object> result = new HashMap<String, Object>();
		List<CouponDTO> list = cDao.selectCouponPayLogList(pi);

		result.put("pi", pi);
		result.put("list", list);

		return result;
	}
}
