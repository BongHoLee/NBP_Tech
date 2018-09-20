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
public class HashService {

    @Autowired
    private ShareDao dao;

    
    
    public Object getList(Object dataMap) {
    	String sqlMapId = "restInfo.HashList";
        Object resultList = dao.getList(sqlMapId, dataMap);

        return resultList;
    }

}