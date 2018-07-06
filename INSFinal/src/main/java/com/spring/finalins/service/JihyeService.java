package com.spring.finalins.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalins.model.InterJihyeDAO;
import com.spring.finalins.model.MemberVO;

@Service
public class JihyeService implements InterJihyeService{
	
	@Autowired
	private InterJihyeDAO dao;
	

	// 개인정보 수정을 위한 로그인한 유저의 정보를 불러오기
	@Override
	public MemberVO getMyProfile(String userid) {
		MemberVO membervo = dao.getMyProfile(userid);		
		return membervo;
	}

	// 회원정보수정 업데이트 하기
	@Override
	public int updateMyProfile(MemberVO membervo) {
		int n = dao.updateMyProfile(membervo);	
		return n;
	}

	// 회원탈퇴(leave_status 업데이트 하기)
	@Override
	public int deleteMyAccount(String userid) {
		int n = dao.deleteMyAccount(userid);
		return n;
	}

}
