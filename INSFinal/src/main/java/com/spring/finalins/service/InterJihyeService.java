package com.spring.finalins.service;

import java.util.HashMap;
import java.util.List;

import com.spring.finalins.model.MemberVO;
import com.spring.finalins.model.TeamVO;

public interface InterJihyeService {

	MemberVO getMyProfile(String userid); // 개인정보 수정을 위한 로그인한 유저의 정보를 불러오기

	int updateMyProfile(MemberVO membervo);  // 회원정보수정 업데이트 하기

	int deleteMyAccount(String userid); // 회원탈퇴(leave_status 업데이트 하기)


	List<TeamVO> getTeamList(String userid); // 내가 속한 팀목록 불러오기
	
	List<HashMap<String, String>> getMyRecordList(String userid); // 내가 활동한 기록 불러오기

	int updateProfileImg(HashMap<String, String> map); // 프로필 이미지 변경하기

	// ==== 차트 그리기 ====
	List<HashMap<String, String>> getChartJSON_job(); // 직업별 인원수
	List<HashMap<String, String>> adminChartJSON_ageline(); // 연령별 인원수

	
	




	

}


