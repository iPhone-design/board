package com.company.test.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository("dao")
public interface BoardDao {

	List<Map<String, Object>> list(Map<String, Object> map);

	int insert(Map<String, Object> map);

	void viewCntADD(int seq);

	Map<String, Object> readByRow(int seq);

	int updateRow(Map<String, Object> map);

	int delete(List<Integer> checkedList);

	int pageMap(Map<String, Object> map);

}
