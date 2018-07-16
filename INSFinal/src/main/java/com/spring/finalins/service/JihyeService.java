package com.spring.finalins.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
	@Override
	public List<TeamVO> getTeamList(String userid) {
		 List<TeamVO> teamList = dao.getTeamList(userid);
		return teamList;
	}

	@Override
	public int updateProfileImg(HashMap<String,String> map) {
		int n = dao.updateProfileImg(map);
		return n;
	}
	

	
	////////////////////////////////////////////////////////////
	// 직업별 인원수(통계)
	@Override
	public List<HashMap<String, String>> getChartJSON_job() {
		List<HashMap<String, String>> jobList = dao.getChartJSON_job();
		return jobList;
	}

	// 연령별 인원수(통계)
	@Override
	public List<HashMap<String, String>> adminChartJSON_ageline() {
		List<HashMap<String, String>> agelineList = dao.adminChartJSON_ageline();
		return agelineList;
	}
   ///////////////////////////////////////////////////////////

	// 내가 활동한 기록 불러오기
	@Override
	public List<HashMap<String, String>> getMyRecordList(String userid) {
		List<HashMap<String, String>> myRecordList = dao.getMyRecordList(userid);
		return myRecordList;
	}




}
