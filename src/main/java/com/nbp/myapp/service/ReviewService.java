package com.nbp.myapp.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nbp.myapp.dao.RestDAO;
import com.nbp.myapp.dao.ShareDao;
import com.nbp.myapp.util.CommonUtil;



/**
* Handles requests for the application home page.
*/
@Service
public class ReviewService {

    @Autowired
    private ShareDao dao;


   public Object saveComment(Map<Object, Object> dataMap) {
	   String sqlMapId = "comment.insert";
	   
	   return dao.saveObject(sqlMapId, dataMap);
	   
   }
   
   public Object saveGrade(Map<String, Object> dataMap) {
	   String sqlMapId = "grade.insert";
	   
	   return dao.saveObject(sqlMapId, dataMap);
   }
   
   public Object updateGrade(Map<String, Object> dataMap) {
	   String sqlMapId = "grade.update";
	   return dao.updateObject(sqlMapId, dataMap);
   }
   
   public Object saveMarking(Map<String, Object> dataMap) {
	   String sqlMapId = "marking.insert";
	   return dao.saveObject(sqlMapId, dataMap);
   }
   
   public Object deleteMarking(Map<String, Object> dataMap) {
	   String sqlMapId = "marking.delete";
	   return dao.deleteObject(sqlMapId, dataMap);
   }
   
   public Object deleteComment(Map<String, Object> dataMap) {
	   String sqlMapId = "comment.delete";
	   
	   return dao.deleteObject(sqlMapId, dataMap);
   }
   
   public Object updateComment(Map<String, Object> dataMap) {
	   String sqlMapId = "comment.update";
	   return dao.updateObject(sqlMapId, dataMap);
   }
   
   public Object getObject(String sqlMapId, Map<String, Object> dataMap) {
	   return dao.getObject(sqlMapId, dataMap);
   }
   
   
   

	

}