package com.spring.finalins.service;

import com.spring.finalins.model.MemberVO;

public interface InterJihyeService {

	MemberVO getMyProfile(String userid); // 개인정보 수정을 위한 로그인한 유저의 정보를 불러오기

	int updateMyProfile(MemberVO membervo);  // 회원정보수정 업데이트 하기

	int deleteMyAccount(String userid); // 회원탈퇴(leave_status 업데이트 하기)

}


