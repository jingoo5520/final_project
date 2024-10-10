package com.finalProject.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.MemberDTO;
import com.finalProject.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO mDao;

	// 아이디 중복검사
	@Override
	public boolean idIsDuplicate(String tmpUserId) throws Exception {
		boolean result = false;
		
		if (mDao.selectDuplicateId(tmpUserId) == 1) {
			result = true;
		}
		return result;
	}
	
	// 회원삽입
	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, rollbackFor = Exception.class)
	public boolean saveMember(MemberDTO registerMember) throws Exception {
		boolean result = false;
		
				// 1) 회원데이터를 DB에 저장 (insert)
				if (mDao.insertMember(registerMember) == 1) {
					result = true;
				}
				
		return result;
	}

}
