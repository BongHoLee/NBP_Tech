package com.nbp.myapp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nbp.myapp.dao.HashDao;
import com.nbp.myapp.dao.RestDAO;
import com.nbp.myapp.dao.ShareDao;
import com.nbp.myapp.util.CommonUtil;



/**
* Handles requests for the application home page.
*/
@Service
public class RestService {

    @Autowired
    private RestDAO dao;
    
    @Autowired
    private HashDao hashdao;
    
	@Autowired
	private CommonUtil util;

    
    // 업체 댓글을 보여줌. 보여주기 전에 XSS 변환 작업 처리
    public Object getCommentList(Object dataMap) {
    	String sqlMapId = "restInfo.CommentList";
        List<Map> resultList = (List)(dao.getCommentList(sqlMapId, dataMap));
       
        return resultList;
    }
    
    //업체 관련 요약 정보를 보여주기 위한 메소드
    public Object getRestInfo(Object dataMap) {
    	String sqlMapId = "restInfo.Rest";
    	Object resultMap = dao.getRestInfo(sqlMapId, dataMap);
    	
    	
    	return resultMap;
    }
    
    //검색 조건에 대한 업체 리스트를 가져옴
    public Object getSearchList(String sqlMapId, Object dataMap) {
    	Object resultList = dao.getSearchList(sqlMapId, dataMap);
    	if(resultList == null) {
    		return null;
    	}
        //해당 업체의 해시 리스트를 넣어준다
        for(Map<String, Object> restInfo : (List<Map>)resultList) {
        	List<Object> hashList = (List)hashdao.getHashList("restInfo.HashList", restInfo);
        	restInfo.put("hashList", hashList);
        }
    	return resultList;
    }
    
    
	

}