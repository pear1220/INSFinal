package com.spring.finalins.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalins.model.InterWoneyDAO;

@Service
public class WoneyService implements InterWoneyService{

	// ===== #31. 의존객체 주입하기(DI: oDependency Injection) =====
	@Autowired
	private InterWoneyDAO dao;
	
}
