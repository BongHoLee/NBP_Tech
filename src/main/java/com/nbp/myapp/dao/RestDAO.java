package com.nbp.myapp.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RestDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//restdetail
	
	// 업체의 댓글 관련 데이터 반환
	public Object getCommentList(String sqlMapId, Object dataMap) {
		Object result = sqlSession.selectList(sqlMapId, dataMap);
		return result;
	}
	
	public Object getRestInfo(String sqlMapId, Object dataMap) {
		Object result = sqlSession.selectOne(sqlMapId, dataMap);
		return result;
	}
	
	public Object getSearchList(String sqlMapId, Object dataMap) {
		//검색 조건에 따른 업체 ID 리스트를 가져온다.
		Object restIdList = sqlSession.selectList(sqlMapId, dataMap);
		
		if(((List)restIdList).size() == 0) {
			return null;
		}
		((Map)dataMap).put("restIdList", restIdList);
		
		//검색된 업체ID 리스트를 이용하여 업체의 정보를 가져온다.
		Object result = sqlSession.selectList("restInfo.searchResult", dataMap);
		return result;
	}
	
	

}
