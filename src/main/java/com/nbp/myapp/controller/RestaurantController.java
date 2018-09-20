package com.nbp.myapp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.nbp.myapp.component.MapParamCollector;
import com.nbp.myapp.dao.ShareDao;
import com.nbp.myapp.service.GradeService;
import com.nbp.myapp.service.HashService;
import com.nbp.myapp.service.MarkingService;
import com.nbp.myapp.service.MenuService;
import com.nbp.myapp.service.RestService;
import com.nbp.myapp.util.CommonUtil;

@Controller
public class RestaurantController {

	@Autowired
	private RestService restService;
	
	@Autowired
	private GradeService gradeService;
	
	@Autowired
	private MarkingService markingService;
	
	@Autowired
	private HashService hashService;
	
	@Autowired
	private MenuService menuService;
	

	

	

	private final static String MAPPING = "/restView";

	@RequestMapping(value = MAPPING + "/{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
			MapParamCollector paramMethodMap, @PathVariable String action, ModelAndView modelandView) {

		
		//paramMap 에 RESTAURANT_ID, MEMBER_KEY 넘어옴
		Map<Object, Object> paramMap = paramMethodMap.getMap();

		String viewName = "/restaurantView" + "/";
		String forwardView = (String) paramMap.get("forwardView");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Object> resultList = new ArrayList<Object>();
		
		List<Object> commentList = new ArrayList<Object>();
		
		//해당 업체의 정보를 받음
		Map<Object, Object> restInfo = new HashMap<Object, Object>();
		
		//유저가 업체에 별점 등록을 헀는지 판단
		Map<Object, Object> gradeInfo = new HashMap<Object, Object>();
		System.out.println("멤버 키 : " + paramMap.get("MEMBER_ID"));	
		
		//유저가 업체를 즐겨찾기 했는지 판단
		Map<Object, Object> markingInfo = new HashMap<Object, Object>();
		
		//업체의 해시 리스트를 가져온다.
		List<Object> hashList = new ArrayList<Object>();
		
		//업체의 메뉴 리스트를 가져온다
		List<Object> menuList = new ArrayList<Object>();
		

		// divided depending on action value
		if ("restlist".equalsIgnoreCase(action)) {
			
			
			if("1".equals(paramMap.get("searchWhat"))) {					//업체 명 검색일시.
				paramMap.put("searchName", "업체 명");
				resultList = (List)restService.getSearchList("searchRestIdForRestNm",paramMap);
			}
			else if("2".equals(paramMap.get("searchWhat"))) {				//메뉴 명 검색일시
				paramMap.put("searchName", "메뉴 명");
				resultList = (List)restService.getSearchList("searchRestIdForMenu", paramMap);
			}
			else if("3".equals(paramMap.get("searchWhat"))) { 			//해시 검색일시.
				paramMap.put("searchName", "#");
				resultList = (List)restService.getSearchList("searchRestIdForHash", paramMap);
			}else if("4".equals(paramMap.get("searchWhat"))) {			//카테고리 검색일시
				paramMap.put("searchName", "카테고리");
				resultList =(List)restService.getSearchList("searchRestIdForCate", paramMap);
			}
			
			if(resultList == null) {
				paramMap.put("search", "noItem");
			}
			 

			viewName = viewName + action;
		} else if("restdetail".equalsIgnoreCase(action)) {
			//업체 관련 댓글 , 업체 세부정보, 현재 유저가 평가를 했는지, 몇명이 평가를 했는지가 필요
			commentList = (List)restService.getCommentList(paramMap);	
			restInfo = (Map)restService.getRestInfo(paramMap);
			gradeInfo = (Map)gradeService.getObject(paramMap);
			markingInfo = (Map)markingService.getObject(paramMap);
			hashList = (List)hashService.getList(paramMap);
			menuList = (List)menuService.getList(paramMap);
			
			if(gradeInfo == null) {
				modelandView.addObject("gradeCheck", 0);
			}
			else {
				modelandView.addObject("gradeCheck", 1);
			}
			
			if(markingInfo == null) {
				modelandView.addObject("markingCheck", 0);
			}else {
				modelandView.addObject("markingCheck", 1);
			}
			
			
			viewName = viewName + action;
			
		}

		resultMap.put("commentList", commentList);
		resultMap.put("resultList", resultList);
		resultMap.put("RESTAURANT_ID", paramMap.get("RESTAURANT_ID"));
		
		modelandView.setViewName(viewName);
		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		modelandView.addObject("restInfo", restInfo);
		modelandView.addObject("gradeInfo", gradeInfo);
		modelandView.addObject("hashList", hashList);
		modelandView.addObject("menuList", menuList);
		
		return modelandView;
	}
	




	

}
