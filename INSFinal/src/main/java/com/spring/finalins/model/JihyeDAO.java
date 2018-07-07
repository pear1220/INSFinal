package com.spring.finalins.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	
}
