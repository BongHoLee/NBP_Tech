package com.nbp.myapp.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nbp.myapp.dao.HashDao;
import com.nbp.myapp.dao.ShareDao;



/**
* Handles requests for the application home page.
*/
@Service
public class HomeService {

    @Autowired
    private ShareDao dao;
    
    @Autowired
    private HashDao hashdao;
   
    // 초기 화면에 전체 업체 목록을 보여주기 위해 업체 요약 정보 데이터 가져오기
    public Object getList(Object dataMap) {
    	String sqlMapId = "restInfo.RestList";
        Object resultList = dao.getList(sqlMapId, dataMap);
        
        //해당 업체의 해시 리스트를 넣어준다
        for(Map<String, Object> restInfo : (List<Map>)resultList) {
        	List<Object> hashList = (List)hashdao.getHashList("restInfo.HashList", restInfo);
        	restInfo.put("hashList", hashList);
        }

        return resultList;
    }
	

}