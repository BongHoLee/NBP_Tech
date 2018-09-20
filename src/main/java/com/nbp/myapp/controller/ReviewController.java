package com.nbp.myapp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nbp.myapp.component.MapParamCollector;
import com.nbp.myapp.service.GradeService;
import com.nbp.myapp.service.HashService;
import com.nbp.myapp.service.MarkingService;
import com.nbp.myapp.service.MenuService;
import com.nbp.myapp.service.RestService;
import com.nbp.myapp.service.ReviewService;
import com.nbp.myapp.util.CommonUtil;

@Controller
public class ReviewController {

	@Autowired
	private RestService restService;

	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private GradeService gradeService;
	
	@Autowired
	private MarkingService markingService;
	
	@Autowired
	private HashService hashService;
	
	@Autowired
	private MenuService menuService;
	

	private final static String MAPPING = "/review";

	@RequestMapping(value = MAPPING + "/{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
			MapParamCollector paramMethodMap, @PathVariable String action, ModelAndView modelandView) {
	
		
		Map<Object, Object> paramMap = paramMethodMap.getMap();
		String viewName = "/restaurantView/restdetail";

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Object> resultList = new ArrayList<Object>();
		
		//해당 업체의 댓글 리스트를 받음
		List<Object> commentList = new ArrayList<Object>(); 
		
		//해당 업체의 정보를 받음
		Map<Object, Object> restInfo = new HashMap<Object, Object>();
		
		//유저가 업체에 별점 등록을 헀는지 판단
		Map<Object, Object> gradeInfo = new HashMap<Object, Object>();
		
		//유저가 업체를 즐겨찾기 했는지 판단
		Map<Object, Object> markingInfo = new HashMap<Object, Object>();
		
		//업체의 해시 리스트를 가져온다.
		List<Object> hashList = new ArrayList<Object>();
		
		//업체의 메뉴 리스트를 가져온다
		List<Object> menuList = new ArrayList<Object>();
		

		// divided depending on action value
		if ("insertReview".equalsIgnoreCase(action)) {
			reviewService.saveComment(paramMap);
			restInfo = (Map)restService.getRestInfo(paramMap);
			commentList = (List)restService.getCommentList(paramMap);
			resultMap.put("commentList", commentList);
			gradeInfo = (Map)gradeService.getObject(paramMap);
			markingInfo = (Map)markingService.getObject(paramMap);
			hashList = (List)hashService.getList(paramMap);
			menuList = (List)menuService.getList(paramMap);
			modelandView.addObject("restInfo", restInfo);
			
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
		} 
		
		
		//resultList = (List)restService.getCommentList(paramMap);
		resultMap.put("resultList", resultList);
		
		resultMap.put("RESTAURANT_ID", paramMap.get("RESTAURANT_ID"));
		modelandView.setViewName(viewName);
		modelandView.addObject("resultMap", resultMap);
		modelandView.addObject("gradeInfo", gradeInfo);
		modelandView.addObject("hashList", hashList);
		modelandView.addObject("menuList", menuList);
		return modelandView;
	}
	
	
	//Ajax 통신 - 별점
	@RequestMapping(value = "/StarPoint", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody Map<String, Object> gradeCall(@RequestBody Map<String, Object> paramMap) throws Exception{

		System.out.println("아약스 값 : " + paramMap.toString());
		Integer result = 0;
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//inesrt 일 시
		if(paramMap.get("updateCheck").equals("insert")) {
			result = (Integer)reviewService.saveGrade(paramMap);
		}else if(paramMap.get("updateCheck").equals("update")) {
			result = (Integer)reviewService.updateGrade(paramMap);
		}
		
		 returnMap.put("data", result);
		 return returnMap;

	}
	
	// 즐겨찾기
	@RequestMapping(value = "/Marking", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody Map<String, Object> markingCall(@RequestBody Map<String, Object> paramMap) throws Exception{

		System.out.println("즐겨찾기 값 : " + paramMap.toString());
		Integer result = 0;
		
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//inesrt 일 시
		if(paramMap.get("markingCheck").equals("insert")) {
			result = (Integer)reviewService.saveMarking(paramMap);
		}else if(paramMap.get("markingCheck").equals("delete")) {
			result = (Integer)reviewService.deleteMarking(paramMap);
		}
		
		 returnMap.put("data", result);
		 return returnMap;

	}
	
	@RequestMapping(value = "/MarkingList", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody Map<String, Object> markingListCall(@RequestParam Map<String, Object> paramMap) throws Exception{
		
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List resultList = (List)markingService.getList(paramMap);
		
		 returnMap.put("data", resultList);
		 return returnMap;

	}
	@RequestMapping(value = "/DeleteComment", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody Map<String, Object> deleteComment(@RequestParam Map<String, Object> paramMap) throws Exception{
		
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Integer result = (Integer)reviewService.deleteComment(paramMap);
		
		 returnMap.put("data", result);
		 return returnMap;

	}
	
	@RequestMapping(value = "/UpdateComment", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody Map<String, Object> updateComment(@RequestBody Map<String, Object> paramMap) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> result = (Map)reviewService.getObject("updatedComment", paramMap);
		result.put("UPDATE_DATE", (result.get("UPDATE_DATE").toString()));
		Integer delete = (Integer)reviewService.updateComment(paramMap);
		returnMap.put("data", result);
		return returnMap;

	}
	

	

}
