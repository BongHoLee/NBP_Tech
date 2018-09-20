package com.nbp.myapp.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HashDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//restdetail
	
	// 업체의 댓글 관련 데이터 반환
	public Object getHashList(String sqlMapId, Object dataMap) {
		Object result = sqlSession.selectList(sqlMapId, dataMap);
		
		return result;
	}
	

	
	

}
