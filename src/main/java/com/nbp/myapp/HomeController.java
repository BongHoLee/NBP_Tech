package com.nbp.myapp;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.nbp.myapp.component.MapParamCollector;
import com.nbp.myapp.security.MemberInfo;
import com.nbp.myapp.service.HomeService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private HomeService service;
	
	
	@RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
			MapParamCollector paramMethodMap, ModelAndView modelandView) {
		
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		UserDetails userDetails = (MemberInfo)principal; 
		MemberInfo user = (MemberInfo) userDetails;
		
		
		

		
		
		
		
		String viewName = "home";

		Map<Object, Object> paramMap = paramMethodMap.getMap();
		List<Object> resultList = new ArrayList<Object>();
		
	
		
		resultList = (List<Object>) service.getList(paramMap);
		modelandView.setViewName(viewName);
		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultList", resultList);

		return modelandView;
	}
}
