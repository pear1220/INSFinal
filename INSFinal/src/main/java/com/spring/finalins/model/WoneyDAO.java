package com.spring.finalins.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//===== DAO 선언 =====
@Repository
public class WoneyDAO implements InterWoneyDAO {

	// ===== #29. 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired
	private SqlSessionTemplate sqlsession;

	
}
