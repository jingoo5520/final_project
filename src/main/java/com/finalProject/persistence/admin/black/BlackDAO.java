package com.finalProject.persistence.admin.black;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.black.BlackMemberVO;
import com.finalProject.model.admin.product.PagingInfo;

public interface BlackDAO {

	int getTotalPostCnt();

	List<BlackMemberVO> getAllMember(PagingInfo pi);

	List<BlackMemberVO> getSearchMember(Map<String, Object> mapperMap);

}
