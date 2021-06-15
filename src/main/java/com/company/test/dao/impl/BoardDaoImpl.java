package com.company.test.dao.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.company.test.dao.BoardDao;

@Repository("dao")
public class BoardDaoImpl implements BoardDao {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<Map<String, Object>> list(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("mapper.list", map);
	}
	
	@Override
	public int insert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("mapper.insert", map);
	}

	@Override
	public void viewCntADD(int seq) {
		sqlSessionTemplate.update("mapper.viewUpdate", seq);
	}

	@Override
	public Map<String, Object> readByRow(int seq) {
		return sqlSessionTemplate.selectOne("mapper.readByRow", seq);
	}

	@Override
	public int updateRow(Map<String, Object> map) {
		return sqlSessionTemplate.update("mapper.updateRow", map);
	}

	@Override
	public int delete(List<Integer> checkedList) {
		return sqlSessionTemplate.delete("mapper.delete", checkedList);
	}

	@Override
	public int pageMap(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("mapper.pageMap", map);
	}
	
}
