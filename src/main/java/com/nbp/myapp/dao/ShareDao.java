package com.nbp.myapp.dao;


import java.util.Map;

import org.jsoup.helper.StringUtil;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

;

@Repository
public class ShareDao{

	@Autowired
	private SqlSessionTemplate sqlSession;

	public Object getList(String sqlMapId, Object dataMap) {
		Object result = sqlSession.selectList(sqlMapId, dataMap);
		return result;
	}

	public Object getObject(String sqlMapId, Object dataMap) {

		Object result = sqlSession.selectOne(sqlMapId, dataMap);
		return result;
	}

	public Object saveObject(String sqlMapId, Object dataMap) {

		Integer result = sqlSession.insert((String)sqlMapId, dataMap);
		return result;
	}

	public Object deleteObject(String sqlMapId, Object dataMap) {
		
		Integer result = sqlSession.delete(sqlMapId,dataMap);
		return result;
	}
	
	public Object updateObject(String sqlMapId, Object dataMap) {
		Integer result = sqlSession.update(sqlMapId, dataMap);
		return result;
	}
	
	
	@SuppressWarnings("unchecked")
	public Object selectPagingList(String sqlMapId, Object dataMap) {
		Map<String, Object> map = (Map<String, Object>)dataMap;
		
		//현재 페이지 번호와 한 페이지에 보여줄 행의 개수를 계산
		String strPageIndex = (String)map.get("PAGE_INDEX");
		String strPageRow = (String)map.get("PAGE_ROW");
		int nPageIndex = 0;
		int nPageRow = 12;
		
		if(StringUtils.isEmpty(strPageIndex) == false) {
			nPageIndex = Integer.parseInt(strPageIndex) - 1;
		}
		if(StringUtils.isEmpty(strPageRow) == false) {
			nPageRow = Integer.parseInt(strPageRow);
		}
		
		map.put("START", (nPageIndex * nPageRow) + 1);
		map.put("END", (nPageIndex * nPageRow) + nPageRow);
		
		return sqlSession.selectList(sqlMapId, map);
		
	}
	

}
