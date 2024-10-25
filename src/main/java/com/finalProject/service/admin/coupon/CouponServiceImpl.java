package com.finalProject.service.admin.coupon;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.admin.CouponDTO;
import com.finalProject.model.admin.CouponPayDTO;
import com.finalProject.model.admin.PagingInfo;
import com.finalProject.model.admin.PagingInfoDTO;
import com.finalProject.persistence.admin.CouponDAO;

@Service
public class CouponServiceImpl implements CouponService {

	@Inject
	CouponDAO cDao;
	
	@Override
	public List<CouponDTO> getCouponList() throws Exception {
		return cDao.selectCouponList();
	}
	
	@Override
	public Map<String, Object> getCouponList(PagingInfoDTO pagingInfoDTO) throws Exception {
		
		PagingInfo pi = makePagingInfo(pagingInfoDTO);
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<CouponDTO> list = cDao.selectCouponList(pi);
		
		result.put("pi", pi);
		result.put("list", list);
				
		return result;
	}
	
	private PagingInfo makePagingInfo(PagingInfoDTO pagingInfoDTO) throws Exception {
		PagingInfo pi = new PagingInfo(pagingInfoDTO);
		
		// setter 호출
		pi.setTotalDataCnt(cDao.getTotalCouponCnt());
		
		pi.setTotalPageCnt();
		pi.setStartRowIndex();
		
		// 페이징 블럭
		pi.setPageBlockNoCurPage();
		pi.setStartPageNoCurBloack();
		pi.setEndPageNoCurBlock();
		
		return pi;
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
	public int payCoupon(List<String> memberIdList, int couponNo) throws Exception {

		List<CouponPayDTO> list = new ArrayList<CouponPayDTO>();
		
		
		// 전체 지급 쿠폰일 때
		if(memberIdList.size() == 1 && memberIdList.get(0) == "All") {
			
		} 
		// 개인 지급 쿠폰일 때
		else {
			for(String memberId : memberIdList) {
				// "-" 빼면 32자리
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String couponCode = uuid.substring(0, 16);
				System.out.println(couponCode);
				
				Timestamp time = new Timestamp(System.currentTimeMillis());
				System.out.println(time);
				
				list.add(new CouponPayDTO(couponNo, couponCode, memberId, time));
				
			}
			
			cDao.insertCouponPayLogs(list);
		}
		
		
		return 0;
	}

	

}
