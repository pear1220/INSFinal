package com.spring.finalins.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalins.model.TeamVO;

//===== #.28 DAO 선언
@Repository
public class JihyeDAO implements InterJihyeDAO{
	
	// ===== #29. 의존객체 주입하기(DI: Dependency Injection)
	// root-context.xml 의 의존객체 설정하기에서 어떤 클래스에 주입할지 알 수 있음
	@Autowired
	private SqlSessionTemplate sqlsession;

	// 개인정보 수정을 위한 로그인한 유저의 정보를 불러오기
	@Override
	public MemberVO getMyProfile(String userid) {
		MemberVO membervo = sqlsession.selectOne("jihye.getMyProfile", userid);		
		return membervo;
	}

	// 회원정보수정 업데이트 하기
	@Override
	public int updateMyProfile(MemberVO membervo) {
		int n = sqlsession.update("jihye.updateMyProfile", membervo);
		
		if(n==1) {
		System.out.println("update가 되었습니다."+n);
		}
		return n;
	}

	// 회원탈퇴(leave_status 업데이트 하기)
	@Override
	public int deleteMyAccount(String userid) {
		int n = sqlsession.update("jihye.deleteMyAccount", userid);	
		return n;
	}

	// 내가 속한 팀목록 불러오기
	@Override
	public List<TeamVO> getTeamList(String userid) {
		
		List<TeamVO> teamList = sqlsession.selectList("jihye.getTeamList", userid);
		
		for(int i = 0; i<teamList.size(); i++) {
		System.out.println("teamName"+teamList.get(i).getTeam_name());
		
		}
		return teamList;
	}

	@Override
	public int updateProfileImg(HashMap<String,String> map) {
		
        int n = sqlsession.insert("jihye.updateProfileImg",map);
				
		if(n==1) {
			System.out.println("프로필 사진 입력에 성공하셨습니다.");
		}
		return n;
	}
	


///////////////////////////////////////////////////////////////////	
	@Override
	public List<HashMap<String, String>> getChartJSON_job() {
		List<HashMap<String, String>> jobList = sqlsession.selectList("jihye.getChartJSON_job");
		return jobList;
	}

	@Override
	public List<HashMap<String, String>> adminChartJSON_ageline() {
		List<HashMap<String, String>> agelineList = sqlsession.selectList("jihye.adminChartJSON_ageline");
		return agelineList;
	}
/////////////////////////////////////////////////////////////////

	// 내가 활동한 기록 불러오기
	@Override
	public List<HashMap<String, String>> getMyRecordList(String userid) {
		List<HashMap<String, String>> myRecordList = sqlsession.selectList("jihye.getMyRecordList", userid);
		return myRecordList;
	}

	
}
