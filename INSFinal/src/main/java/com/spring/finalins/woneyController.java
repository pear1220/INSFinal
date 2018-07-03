package com.spring.finalins;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Component
public class woneyController {
	
	@RequestMapping(value="/index.action", method= {RequestMethod.GET})
	public String index(HttpServletRequest req) {

		return "main/index.tiles";
	}
	
	@RequestMapping(value="/carddetail.action", method= {RequestMethod.GET})
	public String carddetail(HttpServletRequest req) {
		return "carddetail.tiles3";
	}
	
	
}
