package com.nbp.myapp.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nbp.myapp.dao.RestDAO;
import com.nbp.myapp.dao.ShareDao;



/**
* Handles requests for the application home page.
*/
@Service
public class GradeService {

    @Autowired
    private ShareDao dao;

    
    // 해당 업체에 유저가 평점 등록을 했는지 확인하기 위한 메소드
    public Object getObject(Object dataMap) {
    	String sqlMapId = "grade.checkMember";
       Map<String, Object> resultMap = (Map)dao.getObject(sqlMapId, dataMap);

       return resultMap;
        	
        
    }

}