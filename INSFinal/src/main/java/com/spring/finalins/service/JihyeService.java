package com.spring.finalins.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalins.model.InterJihyeDAO;
import com.spring.finalins.model.JihyeDAO;
import com.spring.finalins.model.MemberVO;
import com.spring.finalins.qna.model.QnaVO;
import com.spring.finalins.model.TeamVO;

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

	// 내가 속한 팀목록 불러오기
/*	@Override
	public List<TeamVO> getTeamList(String userid) {
		 List<TeamVO> teamList = dao.getTeamList(userid);
		return teamList;
	}*/

	//@Override
	/*public int insertProfileImg(HashMap<String,String> map) {
		
		System.out.println("확인용");
	
		
		InterJihyeDAO dao2 = new JihyeDAO();
		
		int n = dao2.insertProfileImg(map);
		
		
		return n;
	}*/

	// 프로필 사진 변경하기
	/*@Override
	public int insertProfileImg(HashMap<String, String> map) {
		System.out.println("불러오냐?"
				+ ""
				+ ""
				+ "");
		int n = dao.insertProfileImg(map);
		return n;
	}

	@Override
	public int test() {
		int n = 1;
		System.out.println("test호출");
		return n;
	}*/



}
